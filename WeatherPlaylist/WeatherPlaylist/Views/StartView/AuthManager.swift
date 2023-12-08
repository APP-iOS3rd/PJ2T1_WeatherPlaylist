//
//  AuthManager.swift
//  WeatherPlaylist
//
//  Created by 김성엽 on 12/7/23.
//

import Foundation
import Combine


class AuthManager {
    
    static let shared = AuthManager()
    
    private let authKey: String = {
        let clientID = "YOUR_CLIENT_ID"
        let clientSecret = "YOUR_CLIENT_SECRET"
        let rawKey = "\(clientID):\(clientSecret)"
        let encodedKey = rawKey.data(using: .utf8)?.base64EncodedString() ?? ""
        return "Basic \(encodedKey)"
    }()
    
    // Authentication URL
    private let tokenURL: URL? = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "accounts.spotify.com"
        components.path = "/api/token"
        
        return components.url
    }()
    
    private init() {}
    
    /// Request method for access token.
    func getAccessToken() -> AnyPublisher<String, Error> {
        // strong token url
        guard let url = tokenURL else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        // url request setups
        var urlRequest = URLRequest(url: url)
        // add authKey to "Authorization" for request headers
        urlRequest.allHTTPHeaderFields = ["Authorization": authKey,
                                          "Content-Type": "application/x-www-form-urlencoded"]
        // add query items for request body
        var requestBody = URLComponents()
        requestBody.queryItems = [URLQueryItem(name: "grant_type", value: "client_credentials")]
        urlRequest.httpBody = requestBody.query?.data(using: .utf8)
        urlRequest.httpMethod = "POST"
        // return dataTaskPublisher for request
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                // throw error when bad server response is received
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
        // decode the data with AccessToken decodable model
            .decode(type: AccessToken.self, decoder: JSONDecoder())
        // reinforce for decoded data
            .map { accessToken -> String in
                guard let token = accessToken.token else {
                    print("The access token is not fetched.")
                    return ""
                }
                return token
            }
        // main thread transactions
            .receive(on: RunLoop.main)
        // publisher spiral for AnyPublisher<String, Error>
            .eraseToAnyPublisher()
    }
    
    
    //    static let shared = AuthManager ()
    //    private init() {}
    
//    
    struct Constants {
        static let clientID = "f154ba1541fe4fe6bd13bc423b1f308b"
        static let clientSecret = "c8f3316f7b3f448398bd63c0e9c458a3"
    }
//    
//    
//    var isSignedIn: Bool {
//        return false
//    }
//    private var accessToken: String? {
//        return nil
//    }
//    private var refreshToken: String? {
//        return nil
//    }
//    private var shouldReffreshToken: Bool {
//        return false
//    }
//    //
    public var signInURL: URL? {
        let scopes = "user-read-private"
        let redirectURI = "https://www.naver.com"
        let base = "https://accounts.spotify.com/authorize"
        let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)redirect_uri=\(redirectURI)"
        
        return URL(string: string)
    }
    
//    
//    public func exchangeCodeForToken(code: String, completionHandler: @escaping (Bool) -> ()) {
//        // GET TOKEN
//        
//        guard let url = tokenURL else { return }
//        
//        var components = URLComponents()
//        components.queryItems = [
//            URLQueryItem(name: "grant_type", value: "authorization_code"),
//            URLQueryItem(name: "code", value: code),
//            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
//        ]
//        
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = "POST"
//        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        let basicToken = Constants.clientID + ":" + Constants.clientSecret
//        let data = basicToken.data(using: .utf8)
//        guard let base64String = data?.base64EncodedString() else {
//            completionHandler(false)
//            return
//        }
//        urlRequest.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
//        urlRequest.httpBody = components.query?.data(using: .utf8)
//        URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
//            guard let self = self else { return }
//            if let error = error {
//                print(error.localizedDescription)
//                completionHandler(false)
//                return
//            } else if let data = data {
//                do {
//                    let result = try JSONDecoder().decode(AuthResponse.self, from: data)
//                    print("SUCCESSFULLY REFRESH")
//                    self.cacheToken(result: result)
//                    completionHandler(true)
//                } catch {
//                    print(error.localizedDescription)
//                    completionHandler(false)
//                }
//            }
//        }
//        .resume()
//    }
}
