//
//  PostView.swift
//  SocialNetworkExcecise
//
//  Created by Luis Eugenio Santos Gonzalez on 28/12/23.
//

import SwiftUI
import AVKit

struct PostView: View {

    var post: LoadedPost
    @State var showButton = false
    @Binding var show: Bool
    var namespace: Namespace.ID

    var body: some View {
        ZStack(alignment: .center) {
            VStack(alignment: .center) {
                if !post.loadedImages.isEmpty {
                    if post.loadedImages.count > 1 {
                        PostCarousellView(imageNames: post.loadedImages,
                                          post: post.post,
                                          namespace: namespace)
                    } else if let image = post.loadedImages.first {
                        ImagePostView(imageName: image, 
                                      namespace: namespace)
                    }
                } else if let loadedVideo = post.loadedVideo {
                    VideoPlayerView(loadedVideo: loadedVideo, 
                                    loadedPost: .constant(post),
                                    namespace: namespace,
                                    paused: true)
                }
            }
            .overlay(alignment: .top) {
                Button(action: {
                    withAnimation {
                        show = false
                    }
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.white)
                        .padding(8)
                        .background(.black, in: .circle)
                        .contentShape(Circle())
                })
                .padding(15)
                .padding(.top, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .opacity(showButton ? 1 : 0)
                .animation(.snappy, value: showButton)
            }
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    showButton = true
                }
            })
        }
        .cornerRadius(16, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
    }
}
