//
//  FeedService.swift
//  SocialNetworkExcecise
//
//  Created by Luis Eugenio Santos Gonzalez on 28/12/23.
//

import Foundation
import Combine

class FeedService {
    
    var token: String
    
    init(token: String) {
        self.token = token
    }
    
    func getFeed(urlString: String) async throws -> FeedStructure {
        guard let url = URL(string: urlString) else {
            throw ApiErrors.unknown
        }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization" )

        request.httpMethod = HttpMetods.get.rawValue

        return try await ApiManager.requestNetworkResponse(request: request)
    }
    
    func dummyData() throws -> FeedStructure {
        return try ApiManager.requestDummy()
    }

    func getFeed(urlString: String, isForPreview: Bool) -> AnyPublisher<[PostItem], Error> {
        Future { [weak self] promise in
            guard let strongSelf = self else {
                promise(.failure(ApiErrors.unknown))
                return
            }
            Task {
                do {
                    let feed = isForPreview ?
                    try strongSelf.dummyData() :
                    try await strongSelf.getFeed(urlString: urlString)
                    guard let items = feed.data?.items else {
                        print("NO DATA ITEMS FROM \(#function)")
                        return
                    }
                    var postItems: [PostItem] = []
                    items.forEach { dataItem in
                        if let items = dataItem.items {
                            items.forEach { item in
                                postItems.append(item)
                            }
                        }
                    }
                    let postItemsConstants = postItems
                    DispatchQueue.main.async {
                        promise(.success(postItemsConstants))
                    }
                } catch let error {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()

    }
    
}
