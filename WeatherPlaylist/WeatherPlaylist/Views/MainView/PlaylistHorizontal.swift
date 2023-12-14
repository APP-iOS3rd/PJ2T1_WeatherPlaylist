//
//  PlaylistHorizontal.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/7/23.
//

import SwiftUI

struct PlaylistHorizontal: View {
    @State var sectionTitle: String = ""
    @State var sectionSubTitle: String = "추천 선곡"
    
    let dummyData = MusicListDummyManager().list.prefix(4)
    @State var playlistInfo: PlayListInfo = .init(playlistName: "aaaa",
                                                  playlistDescription: "aaaaaaa",
                                                  coverImageUrl: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                                                  isLikePlaylist: false)
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
            
      
            LazyVStack(alignment: .leading) {
                ForEach(dummyData) { song in
                    PlaylistRowView(id: song.id,
                                    songName: song.songName,
                                    artist: song.artist,
                                    coverImage: song.coverImage,
                                    songTime: song.songTime)
                    
                }
                   
                
            }
            .padding(EdgeInsets(top: 0,
                                leading: 24,
                                bottom: 0,
                                trailing: 24))
        }
    }
}

#Preview {
    PlaylistHorizontal()
}
