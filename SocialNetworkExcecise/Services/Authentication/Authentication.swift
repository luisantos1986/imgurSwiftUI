//
//  Authentication.swift
//  SocialNetworkExcecise
//
//  Created by Luis Eugenio Santos Gonzalez on 28/12/23.
//

import Foundation

class Authentication {

    func getAccessToken() async throws -> TokenResponse {
        guard let url = URL(string: "https://api.imgur.com/oauth2/token") else {
            throw ApiErrors.unknown
        }
        var request = URLRequest(url: url)
        let refreshToken = Defaults.getRefreshToken() ?? ""
        request.httpMethod = HttpMetods.post.rawValue
        let parameters: [String: Any] = [
            "refresh_token": refreshToken,
            "client_id": "client_id",
            "client_secret": "client_secret",
            "grant_type": "refresh_token"
        ]
        request.httpBody = parameters.percentEncoded()
        return try await ApiManager.requestNetworkResponse(request: request)
    }

    
}


extension Dictionary {
    func percentEncoded() -> Data? {
        map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed: CharacterSet = .urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
