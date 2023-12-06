//
//  MyPageView.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/6/23.
//

import SwiftUI

struct MyPageView: View {
    var body: some View {
        VStack {
            ProfileView()
            PlaylistScrollView(title: "저장한 플레이리스트",
                               models: [PlaylistModel(id: "1",
                                                      title: "즐거운 믹스",
                                                     singers: ["슈퍼비", "디핵", "기리보이", "기타등등"]),
                                        PlaylistModel(id: "2",
                                                               title: "즐거운 믹스",
                                                              singers: ["슈퍼비", "디핵", "기리보이", "기타등등"]),
                                        PlaylistModel(id: "3",
                                                               title: "즐거운 믹스",
                                                              singers: ["슈퍼비", "디핵", "기리보이", "기타등등"]),
                                        PlaylistModel(id: "4",
                                                               title: "즐거운 믹스",
                                                              singers: ["슈퍼비", "디핵", "기리보이", "기타등등"])
                               ])
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

