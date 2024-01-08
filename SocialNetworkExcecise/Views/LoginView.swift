//
//  LoginView.swift
//  SocialNetworkExcecise
//
//  Created by Luis Eugenio Santos Gonzalez on 28/12/23.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            Text("Login")
                .padding()
            Button(action: {
               // getAccessToken()
            }, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            })
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
