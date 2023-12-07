//
//  MainPageView.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/7/23.
//

import SwiftUI

struct MainPageView: View {
    
    @State private var menutap = false
    @State var isLightMode: Bool = false
 
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack{
                        headerView
                        MusicSection()
                        //.padding(.bottom, 30) // 하단리스트 여백
                    }
                    .padding()
                }
                
                // 재생중인 음악
                PlayFooterCell(musicImage: "album2",
                               isLightMode: $isLightMode)
               
            }
        }
    }
    
    
    @ViewBuilder private var background: some View {
        if isLightMode {
            Color("lightBg")
               .ignoresSafeArea()
        } else {
            Color("darkBg")
                .ignoresSafeArea()
        }
    }
}

#Preview {
    MainPageView()
}
 

extension MainPageView {
    
    private var headerView: some View{
        HStack {
            Text("화창한 날엔 이 노래 어때요?")
                .font(.bold28)
            Spacer()
        }
    }
}


struct MusicSection: View {
    var body: some View {
        Section{
            HStack{
                VStack(alignment: .leading){
                    Text("추천 리스트")
                        .font(.regular16)
                    Text("맞춤 믹스 : Giommy")
                        .font(.bold20)
                }
                Spacer()
            }.padding(.vertical)
            
            // DisplayView
        }
    }
}
 
