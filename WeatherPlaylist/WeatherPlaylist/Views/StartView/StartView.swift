//
//  StartView.swift
//  WeatherPlaylist
//
//  Created by 김성엽 on 12/7/23.
//

import SwiftUI

struct StartView: View {
    
    @State var isLoading: Bool = true
    
    var body: some View {
        
        ZStack {
            
            // 1) CHANGED: zIndex added
            // 앱 화면
            LoginView()
            
            // Launch Screen
            if isLoading {
                // 2) CHANGED: transition and zIndex added
                LaunchView().transition(.opacity).zIndex(1)
            }
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                // 3) CHANGED: withAnimation added
                withAnimation { isLoading.toggle() }
            })
        }
        
    }
}


#Preview {
    StartView()
}
