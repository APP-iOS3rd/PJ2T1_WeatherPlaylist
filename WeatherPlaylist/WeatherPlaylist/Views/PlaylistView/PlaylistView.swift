//
//  View.swift
//  WeatherPlaylist
//
//  Created by seobe22 on 12/6/23.
//

import SwiftUI

struct PlaylistView: View {
    let dummyData = PlaylistDummyManager().list
    @State var playlistInfo: PlayListInfo = .init(playlistName: "aaaa",
                                                  playlistDescription: "aaaaaaa",
                                                  coverImageUrl: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                                                  isLikePlaylist: false)
    var body: some View {
        NavigationStack {
            VStack {
                HeaderView()
                
                ScrollView(.vertical, showsIndicators: false) {
                    PlaylistCorverImageView(coverImageUrl: playlistInfo.coverImageUrl)
                    
                    LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                        Section {
                            ForEach(dummyData) { song in
                                NavigationLink(destination: {
                                    PlayMusicView(temp: song)
                                        .navigationBarBackButtonHidden()
                                }) {
                                    PlaylistRowView(id: song.id,
                                                    songName: song.songName,
                                                    artist: song.artist,
                                                    coverImage: song.coverImage,
                                                    songTime: song.songTime)
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
            }
        }
    }
}
#Preview {
    PlaylistView()
}
