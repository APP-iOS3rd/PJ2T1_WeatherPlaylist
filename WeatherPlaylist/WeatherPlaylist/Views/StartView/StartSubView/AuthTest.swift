//
//  AuthTest.swift
//  WeatherPlaylist
//
//  Created by 김성엽 on 12/7/23.
//

import WebKit
import SwiftUI

struct AuthView: UIViewRepresentable {
    
    private let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript =  true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        
        let webView = WKWebView(frame: .zero, configuration: config)
        
        return webView
    }()
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = AuthManager.shared.signInURL else {
            return WKWebView()
        }
        let webView = webView
        
        webView.load(URLRequest(url: url))
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: UIViewRepresentableContext<AuthView>) {
        guard let url = AuthManager.shared.signInURL else { return } //URL(string: url) else { return }

        webView.load(URLRequest(url: url))
    }
    
}
