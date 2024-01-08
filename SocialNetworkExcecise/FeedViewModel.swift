//
//  FeedViewModel.swift
//  SocialNetworkExcecise
//
//  Created by Luis Eugenio Santos Gonzalez on 07/01/24.
//

import SwiftUI
import Combine

class FeedViewModel: ObservableObject {
    let numOfColumns: Int = 2
    var urlString = "https://api.imgur.com/3/feed"
    @Published var feedColumns: [FeedColumn] = []
    private var cancellables: Set<AnyCancellable> = []
    @Published var isLoading = false
    var isForPreview = false
    
    func storeLoadedPost(loadedPost: LoadedPost) {
        for column in feedColumns {
            if let columnIndex = feedColumns.firstIndex(where: {$0.id == column.id}),
               let postIndex = feedColumns[columnIndex].postItems.firstIndex(where: {$0.id == loadedPost.id}) {
                feedColumns[columnIndex].postItems[postIndex] = loadedPost
            }
        }
    }

    private func storePost(post: ItemPost, index: Int) {
        // check for duplicates
        for column in feedColumns {
            for postItem in column.postItems {
                if let postItemLink = postItem.post.link,
                   let postLink = post.link {
                    if postItemLink == postLink {
                        return
                    }
                }
            }
        }
        feedColumns[index].postItems.append(LoadedPost(post: post))
    }

    private func populateColumns(postItems: [PostItem]) {
        if self.feedColumns.count < self.numOfColumns {
            var columns: [FeedColumn] = []
            for _ in 0 ..< self.numOfColumns {
                columns.append(FeedColumn())
            }
            self.feedColumns = columns
        }
        // We will store the heights to find the smallest
        var columnsHeight = Array<CGFloat>(repeating: 0, count: self.numOfColumns)

        postItems.forEach { postItem in
            var smallestColumnIndex = 0
            var smallesHeight = columnsHeight.first!
            for i in 1..<columnsHeight.count {
                let currentHeight = columnsHeight[i]
                if currentHeight < smallesHeight {
                    smallesHeight = currentHeight
                    smallestColumnIndex = i
                }
            }
            if let post = postItem.post {
                self.storePost(post: post, index: smallestColumnIndex)
                if let firstImage = postItem.post?.images?.first {
                    columnsHeight[smallestColumnIndex] += CGFloat(firstImage.height)
                }
            }
        }
    }

    func getData() {
        isLoading = true
        if let accessToken = Defaults.getAccessToken() {
            let feedService = FeedService(token: accessToken)
            feedService.getFeed(urlString: urlString, isForPreview: isForPreview)
                .sink { result in
                    self.isLoading = false
                    switch result {
                    case .finished:
                        print("finished")
                    case .failure(_):
                        print("failure")
                    }
                } receiveValue: { postItems in
                    self.populateColumns(postItems: postItems)
                }.store(in: &cancellables)

            }
    }

    func getAccessToken() async throws {
        print(#function)
        let authentication = Authentication()
        let tokenResponse = try await authentication.getAccessToken()
        Defaults.storeTokenResponse(tokenResponse: tokenResponse)
    }
}
