//
//  ContentView.swift
//  SocialNetworkExcecise
//
//  Created by Luis Eugenio Santos Gonzalez on 27/12/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var feedViewModel = FeedViewModel()

    var body: some View {
        VStack {
            if feedViewModel.feedColumns.isEmpty {
                loginView
            } else {
                FeedView(feedViewModel: feedViewModel)
            }
        }
    }
    
    var loginView: some View {
        VStack {
            if feedViewModel.isLoading {
                ProgressView()
            }
            Text("Login")
                .padding()
            Button(action: {
                feedViewModel.getData()
            }, label: {
                Text("Get Data")
            })
            .padding()
            Button(action: {
                Defaults.removeTokens()
            }, label: {
                Text("Clear tokens")
            })
            .padding()
        }
    }
    

}

#Preview {
    ContentView()
}
