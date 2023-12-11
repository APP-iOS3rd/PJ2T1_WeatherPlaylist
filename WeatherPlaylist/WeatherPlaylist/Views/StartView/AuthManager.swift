//
//  AuthManager.swift
//  WeatherPlaylist
//
//  Created by 김성엽 on 12/11/23.
//

import Foundation
import Combine


class AuthManager: ObservableObject  {
    
    static let shared = AuthManager()
    
    func getAccessTokenURL() -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = APIConstants.authHost
        components.path = "/authorize"
        
        components.queryItems = APIConstants.authParams.map({URLQueryItem(name: $0, value: $1)})
        
        guard let url = components.url else { return nil }
        
        return URLRequest(url: url)
    }
}
