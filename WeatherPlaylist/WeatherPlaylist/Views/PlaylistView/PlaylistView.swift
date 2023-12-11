//
//  View.swift
//  WeatherPlaylist
//
//  Created by seobe22 on 12/6/23.
//

import SwiftUI

struct PlaylistView: View {
    @StateObject var viewModel: PlaylistViewModel = .init()
    
    @State var isLightMode: Bool = true
    @State private var isShowingPlayer = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment:.bottom) {
                ScrollView(.vertical, showsIndicators: false) {
                    PlaylistCorverImageView(coverImageUrl: viewModel.playlistInfo.coverImageUrl)
                    
                    LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                        Section {
                            ForEach(viewModel.playlist) { song in
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
                            PlaylistStickyHeader()
                                .environmentObject(viewModel)
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
#Preview {
    PlaylistView()
}
