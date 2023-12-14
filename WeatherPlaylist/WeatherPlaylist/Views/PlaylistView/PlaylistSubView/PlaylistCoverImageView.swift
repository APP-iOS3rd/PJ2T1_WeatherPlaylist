//
//  PlaylistCoverImageView.swift
//  WeatherPlaylist
//
//  Created by seobe22 on 12/6/23.
//

import SwiftUI

struct PlaylistCoverImageView: View {
    var coverImageUrl: String
    
    var body: some View {
        HStack(alignment: .center){
             Image("cdImg")
                 .resizable()
                 .frame(width:180, height:180)
                 .offset(x: 50)
                 .aspectRatio(contentMode: .fit)
             
             CachedImage(url: URL(string: coverImageUrl)) { phase in
                 switch phase {
                 case .success(let image) :
                     image
                         .resizable()
                 case .failure(_), .empty:
                     ProgressView()
                 }
             }
             .frame(width: 180, height: 180)
             .offset(x: -50)
             .aspectRatio(contentMode: .fit)
        }
       
    }
}

 
#Preview {
    PlaylistCoverImageView(coverImageUrl: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4")
}
