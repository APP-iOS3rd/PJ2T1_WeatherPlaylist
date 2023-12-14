//
//  PlaylistView.swift
//  WeatherPlaylist
//
//  Created by seobe22 on 12/6/23.
//

import SwiftUI

struct PlaylistView: View {
    
    let coloredNavAppearance = UINavigationBarAppearance()
 
    @StateObject var viewModel: PlaylistViewModel
    @Environment(\.dismiss) var dismiss
    @State var isLightMode: Bool = true
    @State private var isShowingPlayer = false
    @StateObject var playerManager = PlayerManager.shared

    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                ZStack(alignment: .top) {
                    // Bottom Layer : 플레이리스트
                    VStack(alignment: .leading) {
                        Section {
                            ForEach(viewModel.playlist) { song in
                                PlaylistRowView(id: song.id,
                                                songName: song.songName,
                                                artist: song.artist,
                                                coverImage: song.coverImage,
                                                songTime: song.songTime,
                                                currentName: playerManager.track?.songName ?? ""

                                )
                                .onTapGesture {
                                    playerManager.playTrack(track: song,
                                                            playlistID: viewModel.playlistInfo.id,
                                                            tracklist: viewModel.playlist)
                                    self.isShowingPlayer.toggle()
                                }
                                .fullScreenCover(isPresented: $isShowingPlayer){
                                    PlayMusicView(temp: song)
                                }
                            }
                        }
                    }
                    .padding(.horizontal,24)
                    .padding(.top,420)
                    .padding(.bottom, 50)
                    .background(Color.clear)
                    
                    
                    // Top Layer : Sticky Header
                    GeometryReader { gr in
                        VStack {
                            // Header 높이
                            let h = self.calculateHeight(minHeight: 140,
                                                         maxHeight: 380,
                                                         yOffset: gr.frame(in: .global).minY)
                            
                            // showDescr의 h값은 minheight값 보다 커야합니다.
                            NavigationHeaderView(viewModel: viewModel, showDescr: h > 140 ? true : false, onDismiss: {dismiss()})
                                .frame(width: gr.size.width, height: h)
                                // 상단에 고정하기 위함
                                .offset(y: gr.frame(in: .global).origin.y < 0 // 올라가는지 체크
                                        ? abs(gr.frame(in: .global).origin.y) // 올라갈 때, 아래로 민다.
                                        : -gr.frame(in: .global).origin.y) // 올라가지 않을 때, 밀어올린다.
                           
                        }
                    }
                    
                }
            }
              
        }
        .gesture(
            DragGesture().onEnded{ value in
                if value.location.x - value.startLocation.x > 150 {
                    dismiss()
                }
            }
        )
        .navigationBarHidden(true)
    }
        
    func calculateHeight(minHeight: CGFloat, maxHeight: CGFloat, yOffset: CGFloat) -> CGFloat {
        // SCROLL UP: yOffset은 음수가 됩니다.
        if maxHeight + yOffset < minHeight {
            return minHeight
        }
        // SCROLL DOWN
        return maxHeight + yOffset
    }
}
//#Preview {
//    PlaylistView(viewModel: .init(playlistInfo: "3cEYpjA9oz9GiPac4AsH4n"))
//}
