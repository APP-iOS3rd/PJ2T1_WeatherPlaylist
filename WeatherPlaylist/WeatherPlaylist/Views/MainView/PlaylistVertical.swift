//
//  PlaylistVertical.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/7/23.
//

import SwiftUI

struct PlaylistVertical: View {
    @State var sectionTitle: String = "추천 리스트"
    @State var sectionSubTitle: String = "맞춤 믹스 : Glommy"
    
    var body: some View {
        Section{
            HStack{
                VStack(alignment: .leading){
                    Text(sectionTitle)
                        .font(.regular16)
                    Text(sectionSubTitle)
                        .font(.bold20)
                }
                Spacer()
            }.padding()
             
            DisplayContent()
                .frame(height: 200)
                .padding(.top,8)
        }
    }
}

#Preview {
    PlaylistVertical()
}
