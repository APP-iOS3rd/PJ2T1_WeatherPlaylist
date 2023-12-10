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
    @State private var isShowingPlayer = false
    
    @StateObject var viewModel: PlayMusicViewModel  = .init()
    var body: some View{
    
        HStack(spacing: 20){
            Image(musicImage)
                .resizable()
                .scaledToFit()
                .padding(4)
                .frame(width: 60)
                .cornerRadius(12)
            
            VStack(alignment: .leading){
                Text(viewModel.playMusicModel.title)
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity,alignment: .leading)
                Text(viewModel.playMusicModel.artist)
                    .font(.system(size: 14))
                    .fontWeight(.light)
                    .frame(maxWidth: .infinity,alignment: .leading)
            }.onTapGesture {
                self.isShowingPlayer.toggle()
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
        .fullScreenCover(isPresented: $isShowingPlayer){
            PlayMusicView(temp: MusicModel(id: "bbbb",
                                           songName: "나나나",
                                           artist: "나나나나",
                                           coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                                           songTime: 200))
        }
    }
    
}
//#Preview {
//    PlayFooterCell(musicImage: "album2", isLightMode: .constant(true))
//}
