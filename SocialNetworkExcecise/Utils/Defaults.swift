//
//  Defaults.swift
//  SocialNetworkExcecise
//
//  Created by Luis Eugenio Santos Gonzalez on 28/12/23.
//

import Foundation

struct Defaults {
    
    static func storeTokenResponse(tokenResponse: TokenResponse) {
        
        UserDefaults.standard.set(tokenResponse.accessToken, forKey: "accessToken")
        UserDefaults.standard.set(tokenResponse.refreshToken, forKey: "refreshToken")
    }
    
    static func getAccessToken() -> String? {
        return UserDefaults.standard.value(forKey: "accessToken") as? String
    }
    
    static func getRefreshToken() -> String? {
        return UserDefaults.standard.value(forKey: "refreshToken") as? String
    }

    static func removeTokens() {
        UserDefaults.standard.removeObject(forKey: "accessToken")
        //UserDefaults.standard.removeObject(forKey: "refreshToken")
    }
}
