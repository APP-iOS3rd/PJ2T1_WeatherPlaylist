//
//  PlaylistCoverImageSmallView.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/14/23.
//

import SwiftUI

struct PlaylistCoverImageSmallView: View {
    var coverImageUrl: String
    
    var body: some View {
         CachedImage(url: URL(string: coverImageUrl)) { phase in
             switch phase {
             case .success(let image) :
                 image
                     .resizable()
             case .failure(_), .empty:
                 ProgressView()
             }
         }
         .frame(width: 48, height: 48)
         .aspectRatio(contentMode: .fit)                        
    }
}
 
#Preview {
    PlaylistCoverImageSmallView(coverImageUrl: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4")
}
