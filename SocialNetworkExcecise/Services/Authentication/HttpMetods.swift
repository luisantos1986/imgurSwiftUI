//
//  HttpMetods.swift
//  SocialNetworkExcecise
//
//  Created by Luis Eugenio Santos Gonzalez on 28/12/23.
//

import Foundation

enum HttpMetods: String {
    case post = "POST"
    case get = "GET"
}

enum ApiErrors: Error {
    case failedRequest(Int)
    case emptyData
    case unknown
    case requestFailed(String)
    case noAccessToken
    case wrongPath
}
