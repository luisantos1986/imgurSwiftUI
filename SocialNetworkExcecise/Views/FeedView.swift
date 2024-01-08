//
//  FeedView.swift
//  SocialNetworkExcecise
//
//  Created by Luis Eugenio Santos Gonzalez on 29/12/23.
//

import SwiftUI

struct FeedView: View {

    let spacing: CGFloat = 25
    let horizontalPadding: CGFloat = 25
    @ObservedObject var feedViewModel: FeedViewModel
    @State var show = false
    @State var currentPost: LoadedPost?
    @Namespace private var namespace

    var body: some View {
        feedPosts
            .opacity(show ? 0 : 1)
            .overlay {
                if show {
                    postView
                }
            }
    }

    var postView: some View {
        VStack {
            if let post = currentPost {
                PostView(post: post, show: $show, namespace: namespace)
                    .frame(maxWidth: show ? .infinity : 0)
            }
        }
    }

    var feedPosts: some View {
        GeometryReader { proxy in
            let width = (proxy.size.width - spacing - horizontalPadding ) / 2
            NavigationStack {
                ScrollView {
                    HStack(alignment: .top, spacing: spacing) {
                        ForEach(feedViewModel.feedColumns) { column in
                            LazyVStack(spacing: spacing) {
                                ForEach(column.postItems, id:\.id) { loadedPost in
                                    if let firstImage = loadedPost.post.images?.first {
                                        PostPreviewView(namespace: namespace, 
                                                        loadedPost: loadedPost,
                                                        loadedPostSelected: { loadedPost in
                                            currentPost = loadedPost
                                            withAnimation {
                                                show = true
                                            }
                                        }, onPreviewLoaded: { loadedPost in
                                            feedViewModel.storeLoadedPost(loadedPost: loadedPost)
                                        })
                                        .frame(width: width, height: calculateHeight(width: width,imageSize: firstImage.getSize()))
                                        .onAppear {
                                            if loadedPost.post.id == column.postItems.last?.post.id {
                                                feedViewModel.getData()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, horizontalPadding)
                }
            }
        }
    }
    
    func calculateHeight(width: CGFloat, imageSize: CGSize) -> CGFloat {
        return (imageSize.height * width) / (imageSize.width)
    }
}

/*
#Preview {
    FeedView(postItems: (0...20).map({ i in }))
}
*/

//struct FeedView_Previews: PreviewProvider {
//    @Namespace static var namespace
//    static var previews: some View {
//        FeedView(feedViewModel: <#T##FeedViewModel#>)
//    }
//}
