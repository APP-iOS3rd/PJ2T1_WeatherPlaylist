//
//  APIConstants.swift
//  SpotifyAuthDemo
//
//  Created by 김성엽 on 12/7/23.
//

import Foundation


enum APIConstants {
    static let apiHost = "api.spotify.com"
    static let authHost = "accounts.spotify.com"
    static let clientID = "f154ba1541fe4fe6bd13bc423b1f308b"
    static let clientSecret = "c8f3316f7b3f448398bd63c0e9c458a3"
    static let redirectUri = "https://www.naver.com"
    static let responseType = "token"
    static let scopes = "user-read-private"
    
    static var authParams = [
        "response_type": responseType,
        "client_id": clientID,
        "redirect_uri": redirectUri,
        "scope": scopes
    ]
    
}
