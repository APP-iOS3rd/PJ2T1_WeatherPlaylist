//
//  AuthView.swift
//  WeatherPlaylist
//
//  Created by 김성엽 on 12/7/23.
//

import WebKit
import SwiftUI

struct AuthView: View {
    @ObservedObject var viewModel = WebViewModel()
    
    var body: some View {
        
        WebView(viewModel: viewModel)
        
    }
}
