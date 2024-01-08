//
//  PostPreviewView.swift
//  SocialNetworkExcecise
//
//  Created by Luis Eugenio Santos Gonzalez on 30/12/23.
//

import SwiftUI

struct PostPreviewView: View {
    
    var namespace: Namespace.ID
    @State var loadedPost: LoadedPost {
        didSet {
            onPreviewLoaded(loadedPost)
        }
    }
    var loadedPostSelected: ((LoadedPost) -> Void)
    var onPreviewLoaded: ((LoadedPost) -> Void)

    var body: some View {
        ZStack(alignment: .center) {
            VStack(alignment: .center) {
                if let image = loadedPost.post.images?.first {
                    switch image.type {
                    case .imageJPEG, .imagePNG, .imageGIF:
                        ImagePreviewView(loadedPost: $loadedPost, namespace: namespace, onDataLoaded: { loadedPost in
                           onPreviewLoaded(loadedPost)
                        })
                    case .videoMp4:
                        if let url = URL(string: image.link) {
                            VideoPlayerView(url: url,
                                            loadedPost: $loadedPost,
                                            namespace: namespace,
                                            paused: true)
                                .clipShape(.rect(cornerRadius: 16))
                        }
                    }
                } else if let video = loadedPost.loadedVideo {
                    VideoPlayerView(url: nil,
                                    loadedVideo: video,
                                    loadedPost: $loadedPost,
                                    namespace: namespace, 
                                    paused: true)
                        .clipShape(.rect(cornerRadius: 16))
                }
            }
        }
        .onTapGesture {
            loadedPostSelected(loadedPost)
        }
    }
}

struct PostPreviewView_Previews: PreviewProvider {
    @Namespace static var namespace
    static let loadedPost = LoadedPost(post: ItemPost.default, loadedImages: [
        ImageNames(name: "star.fill", link: "star.fill"),
        ImageNames(name: "heart.fill", link: "star.fill"),
        ImageNames(name: "square.and.arrow.up", link: "star.fill")
    ])
    static var previews: some View {
        
        PostPreviewView(namespace: namespace, loadedPost: loadedPost) { loadedPost in
            print(loadedPost)
        } onPreviewLoaded: { loadedPost in
            print(loadedPost)
        }
    }
}
