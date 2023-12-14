//
//  View.swift
//  WeatherPlaylist
//
//  Created by seobe22 on 12/6/23.
//

import SwiftUI

struct PlaylistView: View {
    @StateObject var viewModel: PlaylistViewModel
    
    @State var isLightMode: Bool = true
    @State private var isShowingPlayer = false
    let playerManager = PlayerManager.shared
    
    var body: some View {
        NavigationView {
            ZStack(alignment:.bottom) {
                ScrollView(.vertical, showsIndicators: false) {
                    PlaylistCorverImageView(coverImageUrl: viewModel.playlistInfo.image ?? "")

                    LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                        Section {
                            ForEach(viewModel.playlist) { song in
                                PlaylistRowView(id: song.id,
                                                songName: song.songName,
                                                artist: song.artist,
                                                coverImage: song.coverImage,
                                                songTime: song.songTime)
                                .onTapGesture {
                                    playerManager.playTrack(track: song,
                                                            playlistID: viewModel.playlistInfo.id,
                                                            tracklist: viewModel.playlist
                                    )
                                    self.isShowingPlayer.toggle()
                                }
                                .fullScreenCover(isPresented: $isShowingPlayer){
                                    PlayMusicView(temp: song)
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
                
//                PlayFooterCell()
            }
        }
        .navigationBarBackButtonTitleHidden()
    }
}
//#Preview {
//    PlaylistView(viewModel: .init(playlistInfo: "3cEYpjA9oz9GiPac4AsH4n"))
//}
