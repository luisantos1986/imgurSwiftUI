//
//  FeedColumnStruct.swift
//  SocialNetworkExcecise
//
//  Created by Luis Eugenio Santos Gonzalez on 03/01/24.
//

import SwiftUI

struct FeedColumn: Identifiable {
    let id: UUID = UUID()
    var postItems: [LoadedPost] = []
}
