//
//  PostContainerView.swift
//  SocialNetworkExcecise
//
//  Created by Luis Eugenio Santos Gonzalez on 03/01/24.
//

import SwiftUI

struct PostContainerView: View {
    var body: some View {

        VStack {
            Divider()
                .background(Color.red)
            HStack {
                PostIconsView(imageName: "heart", count: 27)
                PostIconsView(imageName: "message", count: 27)
                PostIconsView(imageName: "square.and.arrow.up", count: nil)
            }
        }
    }
}

#Preview {
    PostContainerView()
}

struct PostIconsView: View {
    
    let imageName: String
    let count: Int?
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
            if let count = count {
                Text("\(count)")
            }
        }
        
    }
}
