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
    
    var body: some View {
        NavigationView {
            ZStack(alignment:.bottom) {
                ScrollView(.vertical, showsIndicators: false) {
                    PlaylistCorverImageView(coverImageUrl: viewModel.playlistInfo.image ?? "")
                  
                    VStack(alignment: .center, spacing: 6) {
                        Text(viewModel.playlistInfo.mainTitle)
                            .font(.appFont(for: .Bold, size: 22))
                        
                        Text(viewModel.playlistInfo.subitle)
                            .font(.light10)
                    }
                    .padding(.bottom, 32)

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
                
//                PlayFooterCell()
            }
        }
        .navigationBarBackButtonTitleHidden()
    }
}
//#Preview {
//    PlaylistView(viewModel: .init(playlistInfo: "3cEYpjA9oz9GiPac4AsH4n"))
//}
