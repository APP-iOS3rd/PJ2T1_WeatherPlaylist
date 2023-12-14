//
//  PlayControllerView.swift
//  WeatherPlaylist
//
//  Created by seobe22 on 12/6/23.
//

import SwiftUI

struct PlaylistControllerView: View {
    @EnvironmentObject var viewModel: PlaylistViewModel
    @StateObject var playerManager = PlayerManager.shared
    
    var body: some View {
        HStack(alignment: .center, spacing: 57) {
            Button {
                viewModel.pushAddButton()
            } label: {
                Image(systemName: "plus")
                    .foregroundStyle(Color.colorBlack)
                    .font(.system(size: 24))
            }
            
            if $playerManager.isLoading.wrappedValue {
                ProgressView()
            } else {
                Button {
                    viewModel.pushPlayButton()
                } label: {
                    Image(systemName: playerManager.isPlaying == true ? "pause.fill" : "play.fill")
                        .foregroundStyle(Color.colorBlack)
                        .font(.system(size: 40))
                }
            }
            
            Button {
                viewModel.pushLikeButton()
            } label: {
                Image(systemName: viewModel.playlistInfo.isLiked == true  ? "heart.fill" : "heart")
                    .foregroundStyle(viewModel.playlistInfo.isLiked == true  ? .red : Color.colorBlack)
                    .font(.system(size: 24))
            }
        }
    }
}
#Preview {
    PlaylistControllerView()
}
