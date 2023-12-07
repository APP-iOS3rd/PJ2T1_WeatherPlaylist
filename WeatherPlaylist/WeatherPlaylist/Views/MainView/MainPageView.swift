//
//  MainPageView.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/7/23.
//

import SwiftUI

struct MainPageView: View {
    
    @State private var menutap = false
    @State var isLightMode: Bool = true
    
    @State var mainTitle: String = "화창한 날엔 이 노래 어때요?"
 
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack{
                        headerView
                        PlaylistVertical()
                        PlaylistVertical() 
                        PlaylistHorizontal()
                       
                    }
                    .padding(.bottom,40)
                   
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
            Text(mainTitle)
                .font(.bold28)
                .frame(width: 300,alignment: .leading)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .padding()
    }
}

 
