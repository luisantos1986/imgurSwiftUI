//
//  LoadedPostStruct.swift
//  SocialNetworkExcecise
//
//  Created by Luis Eugenio Santos Gonzalez on 03/01/24.
//

import SwiftUI
import AVKit

struct LoadedPost: Identifiable {
    let id = UUID()
    var post: ItemPost
    var loadedImages: [ImageNames] = []
    var loadedVideo: AVAsset?
}

struct ImageNames: Identifiable {
    let id = UUID()
    let name: String
    let link: String // for identify matched geometry effect
    
    func getSavedImage() -> Image? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false),
           let uiImage =  UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(self.name).path) {
            return Image(uiImage: uiImage)
        }
        return Image(systemName: self.name)
    }
    
}
