//
//  MultipleImagesModifier.swift
//  SocialNetworkExcecise
//
//  Created by Luis Eugenio Santos Gonzalez on 03/01/24.
//

import SwiftUI

struct MultpleImagesModifier: ViewModifier {
    let value: Int
    let size: CGSize
    let multiplier: CGFloat = 3
    func body(content: Content) -> some View {
        ZStack {
            content
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .offset(x: (CGFloat(value)*multiplier),
                        y: (CGFloat(value)*multiplier))
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(Color.green, lineWidth: 1)
                        .offset(x: (CGFloat(value)*multiplier),
                                y: (CGFloat(value)*multiplier))
                        
                }
        }
    }
}

extension View {
    func withMultipleImagesModifier(value: Int, size: CGSize) -> some View {
        modifier(MultpleImagesModifier(value: value, size: size))
    }
}
