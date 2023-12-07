//
//  AuthView.swift
//  WeatherPlaylist
//
//  Created by 김성엽 on 12/7/23.
//

import WebKit
import SwiftUI

struct AuthView: UIViewRepresentable {

    public var completionHandler: ((Bool) -> Void)?
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = AuthManager.shared.signInURL else { return }
        // Exchange the code for access token
        guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: {$0.name == "code"})?.value else {
            return
        }
        webView.isHidden = true
        print("Code: \(code)")
    }
    

    func makeUIView(context: Context) -> WKWebView {
        guard let url = AuthManager.shared.signInURL else {
            return WKWebView()
        }
        let webView = WKWebView()
        
        webView.load(URLRequest(url: url))
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: UIViewRepresentableContext<AuthView>) {
        guard let url = AuthManager.shared.signInURL else { return }//URL(string: url) else { return }
        
        guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: {$0.name == "code"})?.value else {
            return
        }
        
        webView.load(URLRequest(url: url))
    }
}
