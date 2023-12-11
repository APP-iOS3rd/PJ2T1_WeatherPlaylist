//
//  StartViewModel.swift
//  WeatherPlaylist
//
//  Created by 김성엽 on 12/11/23.
//

import Foundation

import SwiftUI

enum StackViewType {
    case firstView
    case secondView
}

protocol WebViewHandlerDelegate {
    func receivedJsonValueFromWebView(value: [String: Any?])
    func receivedStringValueFromWebView(value: String)
}

struct AccessToken: Decodable {
    let token: String?
    let type: String?
    let expire: Int?
    
    enum CodingKeys: String, CodingKey {
        case token = "access_token"
        case type = "token_type"
        case expire = "expires_in"
    }
}

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


struct NavigationUtil {
  static func popToRootView() {
      let keyWindow = UIApplication.shared.connectedScenes
              .filter({$0.activationState == .foregroundActive})
              .compactMap({$0 as? UIWindowScene})
              .first?.windows
              .filter({$0.isKeyWindow}).first
    findNavigationController(viewController: keyWindow?.rootViewController)?
      .popToRootViewController(animated: true)
  }
 
  static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
    guard let viewController = viewController else {
      return nil
    }
 
    if let navigationController = viewController as? UINavigationController {
      return navigationController
    }
 
    for childViewController in viewController.children {
      return findNavigationController(viewController: childViewController)
    }
 
    return nil
  }
}
