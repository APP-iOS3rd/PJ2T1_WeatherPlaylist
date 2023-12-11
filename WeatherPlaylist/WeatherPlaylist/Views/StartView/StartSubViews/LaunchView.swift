//
//  LaunchView.swift
//  WeatherPlaylist
//
//  Created by 김성엽 on 12/11/23.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.colorBlue)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                VStack(spacing: 20) {
                    Image(systemName: "cloud")
                        .foregroundStyle(.white)
                        .font(.system(size: 150, weight: .light))
                    
                    Text("오늘이노래")
                        .foregroundStyle(.white)
                        .font(.custom(FontType.Black.rawValue, size: 50))
                }
                .frame(maxWidth: .infinity)
                Spacer()
            }
        }
    }
}
