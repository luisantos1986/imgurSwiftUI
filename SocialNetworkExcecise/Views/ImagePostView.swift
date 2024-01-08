//
//  ImagePostView.swift
//  SocialNetworkExcecise
//
//  Created by Luis Eugenio Santos Gonzalez on 28/12/23.
//

import SwiftUI

struct ImagePostView: View {
    
    var imageName: ImageNames
    var namespace: Namespace.ID
    
    var body: some View {
        if let image = imageName.getSavedImage() {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: imageName.link, in: namespace)
        }
    }
    
}

/*
#Preview {
    ImagePostView()
}
*/
