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
    @StateObject var player = PlayerManager.shared
    
    var body: some View{
        VStack {
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
                    .padding(.leading, 10)
                    
                    VStack(alignment: .center){
                        if let track = playerManager.track {
                            Text(track.songName)
                                .lineLimit(1)
                                .font(.bold18)
                                .frame(maxWidth: .infinity,alignment: .leading)
                            
                            Text(track.artist)
                                .lineLimit(1)
                                .font(.light14)
                                .frame(maxWidth: .infinity,alignment: .leading)
                            
                        } else{
                            Text("음악을 재생하세요.")
                                .lineLimit(1)
                                .font(.bold18)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.horizontal, 10)
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
                .padding(.leading, 15)
            }
//            CustomSlider(value: $player.songTime, maxValue: 30.0)
//                .frame(height: 5)
        }
        .background(
            scheme == .light ? Color("lightBg") : Color("darkBg")
        )
        .overlay(TopBorder().stroke(Color.gray.opacity(0.4), lineWidth:1))
        .ignoresSafeArea(.all)
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
