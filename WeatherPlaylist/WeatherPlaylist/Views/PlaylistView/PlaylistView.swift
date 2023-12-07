//
//  View.swift
//  WeatherPlaylist
//
//  Created by seobe22 on 12/6/23.
//

import SwiftUI

struct PlaylistView: View {
    var playlistName: String
    var playlistDescription: String
    var coverImageUrl: String
    var isLikePlaylist: Bool
    
    let dummyData = PlaylistDummyManager().list
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            PlaylistCorverImageView(coverImageUrl: coverImageUrl)
            
            LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                Section {
                    ForEach(dummyData) { song in
                        PlaylistRowView(id: song.id,
                                        songName: song.songName,
                                        artist: song.artist,
                                        coverImage: song.coverImage,
                                        songTime: song.songTime)
                    }
                } header: {
                    PlaylistStickyHeader(playlistName: playlistName,
                                         playlistDescription: playlistDescription,
                                         isLikePlaylist: isLikePlaylist)
                }
            }
        }
        .padding(EdgeInsets(top: 32,
                            leading: 24,
                            bottom: 0,
                            trailing: 24))
    }
}
