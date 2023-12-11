//
//  PlayControllerView.swift
//  WeatherPlaylist
//
//  Created by seobe22 on 12/6/23.
//

import SwiftUI

struct PlaylistControllerView: View {
    var isLikePlaylist: Bool
    var pushAddButton: () -> Void
    var pushPlayButton: () -> Void
    var pushLikeButton: () -> Void
    
    var body: some View {
        HStack(alignment: .center, spacing: 57) {
            Button {
                pushPlayButton()
            } label: {
                Image(systemName: "plus")
                    .foregroundStyle(.black)
                    .font(.system(size: 24))
            }
            
            Button {
                pushPlayButton()
            } label: {
                Image(systemName: "play.fill")
                    .foregroundStyle(.black)
                    .font(.system(size: 40))
            }
            
            Button {
                pushLikeButton()
            } label: {
                Image(systemName: isLikePlaylist ? "heart.fill" : "heart")
                    .foregroundStyle(.black)
                    .font(.system(size: 24))
            }
        }
    }
}

#Preview {
    PlaylistControllerView(isLikePlaylist: false, pushAddButton: {}, pushPlayButton: {}, pushLikeButton: {})
}
