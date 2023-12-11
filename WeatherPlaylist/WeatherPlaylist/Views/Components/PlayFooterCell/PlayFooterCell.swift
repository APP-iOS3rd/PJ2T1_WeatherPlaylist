//
//  PlayFooterCell.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/7/23.
//

import SwiftUI

struct PlayFooterCell: View {
    
    var musicImage: String
    @Binding var isLightMode: Bool
    
    var body: some View{
    
        HStack(spacing: 20){
            Image(musicImage)
                .resizable()
                .scaledToFit()
                .padding(4)
                .frame(width: 60)
                .cornerRadius(12)
            
            VStack(alignment: .leading){
                Text("노래 제목")
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity,alignment: .leading)
                Text("KISS OR LIFE")
                    .font(.system(size: 14))
                    .fontWeight(.light)
                    .frame(maxWidth: .infinity,alignment: .leading)
            }
            
            Spacer()
            HStack(spacing: 20){
                Image(systemName: "chevron.left.to.line")
                Image(systemName: "play.fill")
                Image(systemName: "chevron.right.to.line")
            }
            .offset(x: -25, y: 0)
            
            
                
        }
        .background(
            isLightMode ? Color("lightBg") : Color("darkBg")
        )
        .ignoresSafeArea()

    }
    
}
#Preview {
    PlayFooterCell(musicImage: "album2", isLightMode: .constant(true))
}
