//
//  MAnchorKey.swift
//  SocialNetworkExcecise
//
//  Created by Luis Eugenio Santos Gonzalez on 02/01/24.
//

import SwiftUI

/// For reading the source and destination view bounds for our custom matched geometry effect
struct MAnchorKey: PreferenceKey {
    static var defaultValue: [String: Anchor<CGRect>] = [:]
    static func reduce(value: inout [String : Anchor<CGRect>], nextValue: () -> [String : Anchor<CGRect>]) {
        value.merge(nextValue()) { $1 }
    }
}
