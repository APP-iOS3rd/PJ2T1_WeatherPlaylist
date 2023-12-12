//
//  RootView.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/12/23.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        VStack {
            MainPageView()
            PlayFooterCell()
        }
    }
}

#Preview {
    RootView()
}
