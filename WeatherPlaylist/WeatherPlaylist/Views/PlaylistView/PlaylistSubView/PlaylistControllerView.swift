//
//  PlayControllerView.swift
//  WeatherPlaylist
//
//  Created by seobe22 on 12/6/23.
//

import SwiftUI

struct PlayControllerView: View {
    var isLikePlaylist: Bool
    
    var body: some View {
        HStack(alignment: .center, spacing: 57) {
            Button {
                print("push ADD BUTTON")
            } label: {
                Image(systemName: "plus")
                    .foregroundStyle(.black)
                    .font(.system(size: 24))
            }
            
            Button {
                print("push PLAY BUTTON")
            } label: {
                Image(systemName: "play.fill")
                    .foregroundStyle(.black)
                    .font(.system(size: 40))
            }
            
            Button {
                print("push HEART BUTTON")
            } label: {
                Image(systemName: isLikePlaylist ? "heart.fill" : "heart")
                    .foregroundStyle(.black)
                    .font(.system(size: 24))
            }
        }
    }
}
