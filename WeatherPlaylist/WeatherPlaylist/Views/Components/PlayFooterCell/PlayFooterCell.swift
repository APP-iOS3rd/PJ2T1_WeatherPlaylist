//
//  PlayFooterCell.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/7/23.
//

import SwiftUI

struct PlayFooterCell: View {
    @Environment(\.colorScheme) var scheme
    @State private var isShowingPlayer = false
    @StateObject var viewModel: PlayMusicViewModel  = .init()
    
    var body: some View{
    
        HStack {
            HStack{
                AsyncImage(url:
                            URL(string: viewModel.playMusicModel.coverImage)) {
                    image in
                    image
                        .resizable()
                        .padding(8)
                        
                }
                placeholder: {
                    ProgressView()
                }
                .scaledToFit()
                .frame(width: 60,height: 60)
                .cornerRadius(12)
            
                VStack(alignment: .leading){
                    Text(viewModel.playMusicModel.songName)
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity,alignment: .leading)
                    Text(viewModel.playMusicModel.artist)
                        .font(.system(size: 14))
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity,alignment: .leading)
                }
            }.onTapGesture {
                self.isShowingPlayer.toggle()
            }
            
            Spacer()
            HStack(spacing: 10){
                Image(systemName: "backward.end.fill") 
                Image(systemName: "play.fill")
                Image(systemName: "forward.frame.fill")
            }
            .offset(x: -25, y: 0)
        }
        .background(
            scheme == .light ? Color("lightBg") : Color("darkBg")
        )
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $isShowingPlayer){
            // 해당 부분 통일
            PlayMusicView(temp: PlaylistTrackModel(id: "aaa",
                                                    songName: "title",
                                                    artist: "artist",
                                                    coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                                                    songTime: 200))
        }
        
    }
    
}
//#Preview {
//    PlayFooterCell(musicImage: "album2", isLightMode: .constant(true))
//}
