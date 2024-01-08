//
//  TokenResponseStructure.swift
//  SocialNetworkExcecise
//
//  Created by Luis Eugenio Santos Gonzalez on 29/12/23.
//

import Foundation

// MARK: - TokenResponse
struct TokenResponse: Codable {
    let accessToken: String
    let expiresIn: Int
    let tokenType: String
    let refreshToken: String
    let accountID: Int
    let accountUsername: String

    enum CodingKeys: String, CodingKey, CaseIterable {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case tokenType = "token_type"
        case refreshToken = "refresh_token"
        case accountID = "account_id"
        case accountUsername = "account_username"
    }
    
}
