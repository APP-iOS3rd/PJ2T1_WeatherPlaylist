//
//  MyPageView.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/6/23.
//

import SwiftUI

struct MyPageView: View {
    @StateObject var viewModel: ProfileViewModel = .init()
    var body: some View {
        VStack {
            ProfileView()
                .environmentObject(viewModel)
            PlaylistScrollView(title: "저장한 플레이리스트")
            .environmentObject(viewModel)
            VStack(alignment: .leading){
                Text("설정")
                HStack{
                    Text("날씨 반영 설정")
                    Spacer()
                    Toggle(isOn: .constant(true), label: {})
                }
            }.padding(.top)
            .padding(.horizontal, 25)
            Spacer()
        }
    }
}

#Preview {
    MyPageView()
}

