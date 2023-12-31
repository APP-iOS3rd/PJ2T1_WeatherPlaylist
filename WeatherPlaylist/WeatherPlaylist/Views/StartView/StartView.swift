//
//  StartView.swift
//  WeatherPlaylist
//
//  Created by 김성엽 on 12/11/23.
//

import SwiftUI

struct StartView: View {
    
    var body: some View {
        if let _ = UserDefaults.standard.value(forKey: "AccessToken") {
            RootView()
                .navigationBarHidden(true)
        } else {
            LoginView()
                .transition(.opacity)
                .zIndex(1)
        }
    }
}


#Preview {
    StartView()
}