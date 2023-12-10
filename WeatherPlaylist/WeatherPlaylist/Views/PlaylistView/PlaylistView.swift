//
//  View.swift
//  WeatherPlaylist
//
//  Created by seobe22 on 12/6/23.
//

import SwiftUI

struct PlaylistView: View {
    
    @State var isLightMode: Bool = true
    @State private var isShowingPlayer = false
    
    let dummyData = MusicListDummyManager().list
    @State var playlistInfo: PlayListInfo = .init(playlistName: "aaaa",
                                                  playlistDescription: "aaaaaaa",
                                                  coverImageUrl: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                                                  isLikePlaylist: false)
    var body: some View {
        NavigationView {
            ZStack(alignment:.bottom)  {
                ScrollView(.vertical, showsIndicators: false) {
                    PlaylistCorverImageView(coverImageUrl: playlistInfo.coverImageUrl)
                    
                    LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
         
                        Section {
                            ForEach(dummyData) { song in
                                    PlaylistRowView(id: song.id,
                                                    songName: song.songName,
                                                    artist: song.artist,
                                                    coverImage: song.coverImage,
                                                    songTime: song.songTime)
                                    .onTapGesture {
                                        self.isShowingPlayer.toggle()
                                    }
                                    .fullScreenCover(isPresented: $isShowingPlayer){
                                        PlayMusicView(temp: song)
                                    }
                            }
                        } header: {
                            PlaylistStickyHeader(playlistInfo: playlistInfo)
                        }
                        
                        
                    }
                }
                .padding(EdgeInsets(top: 0,
                                    leading: 24,
                                    bottom: 0,
                                    trailing: 24))
                PlayFooterCell(musicImage: "album2",
                               isLightMode: $isLightMode)
             
            }

        }
      
     
      
     

        
    }
}
//#Preview {
//    PlaylistView(, checkModal: <#Binding<Bool>#>)
//}
