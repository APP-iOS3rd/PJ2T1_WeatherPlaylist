//
//  PlayFooterCell.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/7/23.
//

import SwiftUI

struct PlayFooterCell: View {
    @Environment(\.colorScheme) var scheme
    @EnvironmentObject var playerManager: PlayerManager
    @State private var isShowingPlayer = false
    @StateObject var viewModel: PlayMusicViewModel  = .init()
    
    var body: some View{
        
        HStack {
            HStack{
                    AsyncImage(url:
                                URL(string: playerManager.track?.coverImage ?? "")) {
                        image in
                        image
                            .resizable()
                            .padding(8)
                        
                    } placeholder: {
                    ProgressView()
                }
                .scaledToFit()
                .frame(width: 60,height: 60)
                .cornerRadius(12)
                
                VStack(alignment: .leading){
                    Text(playerManager.track?.songName ?? "음악을 재생하세요")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity,alignment: .leading)
                    Text(playerManager.track?.artist ?? "")
                        .font(.system(size: 14))
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity,alignment: .leading)
                }
            }.onTapGesture {
                self.isShowingPlayer.toggle()
            }
            
            Spacer()
            HStack(spacing: 20){
                Image(systemName: "chevron.left.to.line")
                    .onTapGesture {
                        playerManager.goPrevTrack()
                    }
                Image(systemName: playerManager.isPlaying ? "pause.fill" : "play.fill")
                    .onTapGesture {
                        if playerManager.isPlaying {
                            playerManager.pause()
                        } else {
                            playerManager.play()
                        }
                    }
                Image(systemName: "chevron.right.to.line")
                    .onTapGesture {
                        playerManager.goNextTrack()
                    }
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
                                                   songTime: 200,
                                                   url: ""
                                                  ))
        }
        
    }
    
}
//#Preview {
//    PlayFooterCell(musicImage: "album2", isLightMode: .constant(true))
//}
