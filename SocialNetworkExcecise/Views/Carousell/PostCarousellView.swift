//
//  PostCarousellView.swift
//  SocialNetworkExcecise
//
//  Created by Luis Eugenio Santos Gonzalez on 28/12/23.
//

import SwiftUI

struct PostCarousellView: View {
    
    var imageNames: [ImageNames]
    var post: ItemPost
    @State var index = 0
    var namespace: Namespace.ID
    
    var body: some View {
        GeometryReader{ proxy in
                PostImageCarousellView(index: $index, items: imageNames,
                                       spacing: proxy.size.width/8,
                                       trailingSpace: proxy.size.width/4) { imagePost in
                    ImagePostView(imageName: imagePost, namespace: namespace)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
        }
    }
}

//struct PostCarousellView_Previews: PreviewProvider {
//    @Namespace static var namespace
//    static var previews: some View {
//        PostCarousellView(imageNames: [
//            ImageNames(name: "star.fill", link: "star.fill"),
//            ImageNames(name: "heart.fill", link: "star.fill"),
//            ImageNames(name: "square.and.arrow.up", link: "star.fill")
//        ], post: ItemPost.default, namespace: namespace)
//    }
//}
