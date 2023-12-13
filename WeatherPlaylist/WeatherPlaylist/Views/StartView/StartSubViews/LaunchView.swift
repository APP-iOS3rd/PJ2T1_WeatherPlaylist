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
                .foregroundStyle(Color.accentColor)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                VStack(spacing: 20) {
                    Image("appIcon")
                        .frame(width: 300)
                       
                    
                    Text("오늘 뭐 듣지?")
                        .foregroundStyle(.white)
                        .font(.custom(FontType.Black.rawValue, size: 32))
                }
                .frame(maxWidth: .infinity)
                Spacer()
            }
        }
    }
}

#Preview {
    LaunchView()
}
