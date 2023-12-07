//
//  VM.swift
//  SpotifyAuthDemo
//
//  Created by 김성엽 on 12/7/23.
//

import UIKit
import SwiftUI
import Combine
import WebKit

protocol WebViewHandlerDelegate {
    func receivedJsonValueFromWebView(value: [String: Any?])
    func receivedStringValueFromWebView(value: String)
}



struct WebView: UIViewRepresentable {
    var url: String?
    @ObservedObject var viewModel: WebViewModel
    
    // 변경 사항을 전달하는 데 사용하는 사용자 지정 인스턴스를 만듭니다.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // 뷰 객체를 생성하고 초기 상태를 구성합니다. 딱 한 번만 호출됩니다.
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = false  // JavaScript가 사용자 상호 작용없이 창을 열 수 있는지 여부
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator    // 웹보기의 탐색 동작을 관리하는 데 사용하는 개체
        webView.allowsBackForwardNavigationGestures = false    // 가로로 스와이프 동작이 페이지 탐색을 앞뒤로 트리거하는지 여부
        webView.scrollView.isScrollEnabled = true    // 웹보기와 관련된 스크롤보기에서 스크롤 가능 여부
        
        if let urlRequest = APIService.shared.getAccessTokenURL() {
            webView.load(urlRequest)    // 지정된 URL 요청 개체에서 참조하는 웹 콘텐츠를로드하고 탐색
        }
        return webView
    }
    
    // 지정된 뷰의 상태를 다음의 새 정보로 업데이트합니다.
    func updateUIView(_ webView: WKWebView, context: Context) {
        
        
    }
    
    // 탐색 변경을 수락 또는 거부하고 탐색 요청의 진행 상황을 추적
    class Coordinator : NSObject, WKNavigationDelegate {
        var parent: WebView
        var foo: AnyCancellable? = nil
        
        // 생성자
        init(_ uiWebView: WebView) {
            self.parent = uiWebView
        }
        
        // 소멸자
        deinit {
            foo?.cancel()
        }
        
        // 지정된 기본 설정 및 작업 정보를 기반으로 새 콘텐츠를 탐색 할 수있는 권한을 대리인에게 요청
        func webView(_ webView: WKWebView,
                     decidePolicyFor navigationAction: WKNavigationAction,
                     decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

            return decisionHandler(.allow)
        }
        
        // 기본 프레임에서 탐색이 시작되었음
        func webView(_ webView: WKWebView,
                     didStartProvisionalNavigation navigation: WKNavigation!) {
            print("기본 프레임에서 탐색이 시작되었음")
        }
        
        // 탐색이 완료 되었음
        func webView(_ webview: WKWebView,
                     didFinish: WKNavigation!) {
            guard let urlString = webview.url?.absoluteString else { return }
            
            print(urlString)
        }

    }
}
