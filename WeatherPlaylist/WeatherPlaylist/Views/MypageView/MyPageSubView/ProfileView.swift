//
//  ProfileView.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/6/23.
//

import Foundation
import SwiftUI
struct ProfileView: View {
    var body: some View {
        HStack{
            Circle()
                .frame(width: 40, height: 40)
                .padding(.trailing,13)
            Text("닉네임")
            Spacer()
            Button(action: {}, label: {
                Text("수정")
            })
        }.padding(.horizontal,25)
    }
}
#Preview {
    ProfileView()
}
