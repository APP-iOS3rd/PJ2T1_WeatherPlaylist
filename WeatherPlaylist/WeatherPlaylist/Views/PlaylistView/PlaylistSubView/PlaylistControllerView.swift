//
//  PlayControllerView.swift
//  WeatherPlaylist
//
//  Created by seobe22 on 12/6/23.
//

import SwiftUI

struct PlaylistControllerView: View {
    @EnvironmentObject var viewModel: PlaylistViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 57) {
            Button {
                viewModel.pushAddButton()
            } label: {
                Image(systemName: "plus")
                    .foregroundStyle(.black)
                    .font(.system(size: 24))
            }
            
            Button {
                viewModel.pushPlayButton()
            } label: {
                Image(systemName: viewModel.playlistInfo.isPlaying ? "pause.fill" : "play.fill")
                    .foregroundStyle(.black)
                    .font(.system(size: 40))
            }
            
            Button {
                viewModel.pushLikeButton()
            } label: {
                Image(systemName: viewModel.playlistInfo.isLikePlaylist ? "heart.fill" : "heart")
                    .foregroundStyle(viewModel.playlistInfo.isLikePlaylist ? .red : .black)
                    .font(.system(size: 24))
            }
        }
    }
}
#Preview {
    PlaylistControllerView()
}
