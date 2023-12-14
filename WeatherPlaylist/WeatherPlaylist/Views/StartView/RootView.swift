//
//  RootView.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/12/23.
//

import SwiftUI

struct RootView: View {
    var playerManager = PlayerManager.shared
    
    var body: some View {
        VStack(spacing: 0) {
            MainPageView()
            PlayFooterCell()
                .environmentObject(playerManager)
        }
    }
}

#Preview {
    RootView()
}
