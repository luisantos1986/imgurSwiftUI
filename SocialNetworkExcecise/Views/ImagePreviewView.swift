//
//  ImagePreviewView.swift
//  SocialNetworkExcecise
//
//  Created by Luis Eugenio Santos Gonzalez on 30/12/23.
//

import SwiftUI

struct ImagePreviewView: View {
    
    @Binding var loadedPost: LoadedPost {
        didSet {
            if loadedPost.loadedImages.count == loadedPost.post.images?.count {
                onDataLoaded(loadedPost)
            }
        }
    }
    var namespace: Namespace.ID
    var onDataLoaded: ((LoadedPost) -> Void)
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                if !loadedPost.loadedImages.isEmpty,
                   loadedPost.loadedImages.count == loadedPost.post.images?.count {
                    ForEach(0..<loadedPost.loadedImages.count, id:\.self) { index in
                        loadedPost.loadedImages[index].getSavedImage()?
                            .resizable()
                            .centerCropped()
                            .matchedGeometryEffect(id: loadedPost.loadedImages[index].link, in: namespace)
                            .withMultipleImagesModifier(value: index, size: proxy.size)
                    }
                } else if let images = loadedPost.post.images {
                    ForEach(0..<images.count, id: \.self) { index in
                        AsyncImage(
                            url: URL(string: images[index].link),
                            content: {image in
                                image
                                    .resizable()
                                    .centerCropped()
                                    .matchedGeometryEffect(id: images[index].link, in: namespace)
                                    .withMultipleImagesModifier(value: index, size: proxy.size)
                                    .onAppear {
                                        if let imageName = images[index].link.split(separator: "/").last,
                                           image.saveImage(fileName: String(imageName)) {
                                            loadedPost.loadedImages.append(ImageNames(name: String(imageName),
                                                                                      link: images[index].link))
                                        }
                                    }
                            }, placeholder: {
                                ProgressView()
                            }
                        )
                    }
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .if(loadedPost.post.images?.count == 1) { singleImage in
                singleImage
                    .clipShape(.rect(cornerRadius: 16))
            }
        }
    }

}

extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }
}

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

//#Preview {
//    ImagePreviewView(post: ItemPost.default, cachedPost: .constant(nil))
//        .frame(width: 200, height: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//}

extension Image {
    @MainActor
    func saveImage(fileName: String) -> Bool {
        guard let image = ImageRenderer(content: self).uiImage else {
            print("debug:: Cannot make image")
             return false
        }
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            print("debug:: Cannot make jpeg")
            return false
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            print("debug:: Cannot make directory")
            return false
        }
        do {
            if let fileDirectory = directory.appendingPathComponent(fileName) {
                try data.write(to: fileDirectory)
            } else {
                print("debug:: Cannot make fileDirectory")
                return false
            }
            return true
        } catch {
            print("debug:: error \(error.localizedDescription)")
            return false
        }
    }
}
