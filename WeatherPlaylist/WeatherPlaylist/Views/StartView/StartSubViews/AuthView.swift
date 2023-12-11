//
//  AuthView.swift
//  WeatherPlaylist
//
//  Created by 김성엽 on 12/11/23.
//

import UIKit
import SwiftUI
import Combine
import WebKit


struct AuthView: UIViewRepresentable {
    var url: String?
    
    // 변경 사항을 전달하는 데 사용하는 사용자 지정 인스턴스를 만듭니다.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // 뷰 객체를 생성하고 초기 상태를 구성합니다. 딱 한 번만 호출
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = false  // JavaScript가 사용자 상호 작용없이 창을 열 수 있는지 여부
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator    // 웹보기의 탐색 동작을 관리하는 데 사용하는 개체
        webView.allowsBackForwardNavigationGestures = false    // 가로로 스와이프 동작이 페이지 탐색을 앞뒤로 트리거하는지 여부
        webView.scrollView.isScrollEnabled = true    // 웹보기와 관련된 스크롤보기에서 스크롤 가능 여부
        
        if let urlRequest = AuthManager.shared.getAccessTokenURL() {
            webView.load(urlRequest)    // 지정된 URL 요청 개체에서 참조하는 웹 콘텐츠를로드하고 탐색
        }
        return webView
    }

    // 변경사항이 있을 때 호출
    func updateUIView(_ webView: WKWebView, context: Context) {
        if let _ = UserDefaults.standard.value(forKey: "Authorization") {
            DispatchQueue.main.async {
                NavigationUtil.popToRootView()
            }
        }
    }
    
    // 탐색 변경을 수락 또는 거부하고 탐색 요청의 진행 상황을 추적
    class Coordinator : NSObject, WKNavigationDelegate {
        var parent: AuthView
        
        // 생성자
        init(_ uiWebView: AuthView) {
            self.parent = uiWebView
        }
        
        // 지정된 기본 설정 및 작업 정보를 기반으로 새 콘텐츠를 탐색 할 수있는 권한을 대리인에게 요청
        func webView(_ webView: WKWebView,
                     decidePolicyFor navigationAction: WKNavigationAction,
                     decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

            return decisionHandler(.allow)
        }
        
        // API 통신을 통해 token 값이 포함되어 있는 String을 받았을 때
        func webView(_ webview: WKWebView,
                     didFinish: WKNavigation!) {
            guard let urlString = webview.url?.absoluteString else { return }
            

            var tokenString = ""
            if urlString.contains("#access_token=") {
                let range = urlString.range(of: "#access_token=")
                guard let index = range?.upperBound else { return }
                
                
                tokenString = String(urlString[index...])
                // print(tokenString)
            }
            
            if !tokenString.isEmpty {
                let range = tokenString.range(of: "&token_type=Bearer")
                guard let index = range?.lowerBound else { return }
                
                tokenString = String(tokenString[..<index])
                print(tokenString)
                UserDefaults.standard.setValue(tokenString, forKey: "Authorization")
            }
        }
    }
}