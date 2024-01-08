//
//  ApiManager.swift
//  SocialNetworkExcecise
//
//  Created by Luis Eugenio Santos Gonzalez on 28/12/23.
//

import Foundation

typealias NetworkResponse = (data: Data?, response: URLResponse?)

struct ApiManager {

    static func requestNetworkResponse<T: Decodable>(request: URLRequest) async throws -> T {
        let response = try await URLSession.shared.data(for: request)
        return try handleNetworkResponse(response)
    }

    private static func handleNetworkResponse<T: Decodable>(_ response: NetworkResponse) throws -> T {
        if let httpResponse = response.response as? HTTPURLResponse {
            if !(200..<400).contains(httpResponse.statusCode) {
                if let data = response.data, let dataString = String(data: data, encoding: .utf8) {
                    throw ApiErrors.requestFailed(dataString)
                }
                throw ApiErrors.failedRequest(httpResponse.statusCode)
            }
        }
        guard let data = response.data else {
            throw ApiErrors.emptyData
        }

        return try JSONDecoder().decode(T.self, from: data)
    }

    static func requestDummy() throws -> FeedStructure {
        if let path = Bundle.main.path(forResource: "Feed", ofType: "json") {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return try JSONDecoder().decode(FeedStructure.self, from: data)
        }
        throw ApiErrors.wrongPath
    }
}
