//
//  FirstAppearModifier.swift
//  SocialNetworkExcecise
//
//  Created by Luis Eugenio Santos Gonzalez on 03/01/24.
//

import Foundation
import SwiftUI

private struct FirstAppear: ViewModifier {
    let action: () -> Void

    // Use @StateObject to persist the state across view's lifetime
    @StateObject private var isFirstAppear = FirstAppearState()

    func body(content: Content) -> some View {

        content.onAppear {
            if isFirstAppear.value {
                isFirstAppear.value = false
                action()
            } else {
            }
        }
    }
}

// Create a separate class to hold the isFirstAppear state
private class FirstAppearState: ObservableObject {
    @Published var value: Bool = true
}

extension View {
    func onFirstAppear(_ action: @escaping () -> Void) -> some View {
        modifier(FirstAppear(action: action))
    }
}
