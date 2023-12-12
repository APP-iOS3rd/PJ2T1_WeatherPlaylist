//
//  StartView.swift
//  WeatherPlaylist
//
//  Created by 김성엽 on 12/11/23.
//

import SwiftUI

struct StartView: View {
    
    @State var isLoading: Bool = false
    
    var body: some View {
        
        ZStack {
            if isLoading {
                if let _ = UserDefaults.standard.value(forKey: "AccessToken") {
                    RootView()
                        .navigationBarHidden(true)
                } else {
                    LoginView()
                        .transition(.opacity)
                        .zIndex(1)
                }
            } else {
                LaunchView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(
                            deadline: .now() + 3,
                            execute: { withAnimation { isLoading.toggle() }
                        })
                    }
            }
        }
    }
}


#Preview {
    StartView()
}

