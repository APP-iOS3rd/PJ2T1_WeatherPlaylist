//
//  View.swift
//  WeatherPlaylist
//
//  Created by seobe22 on 12/6/23.
//

import SwiftUI

struct PlaylistView: View {
    @StateObject var viewModel: PlaylistViewModel = .init()
    var body: some View {
        NavigationStack {
            VStack {
//                HeaderView()
//                    .background(.cyan)
                ScrollView(.vertical, showsIndicators: false) {
                    PlaylistCorverImageView(coverImageUrl: viewModel.playlistInfo.coverImageUrl)
                    
                    LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                        Section {
                            ForEach(viewModel.playlist) { song in
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
                            PlaylistStickyHeader()
                                .environmentObject(viewModel)
                        }
                    }
                }
                .padding(EdgeInsets(top: 0,
                                    leading: 24,
                                    bottom: 0,
                                    trailing: 24))
            }
        }
//        .toolbar(.hidden)
    }
}
#Preview {
    PlaylistView()
}
