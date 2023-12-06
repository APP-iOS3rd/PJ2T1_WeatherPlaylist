//
//  PlaylistCorverImageView.swift
//  WeatherPlaylist
//
//  Created by seobe22 on 12/6/23.
//

import SwiftUI

struct PlaylistCorverImageView: View {
    var coverImageUrl: String
    
    var body: some View {
        ZStack(alignment: .playlistCoverImageAlignment) {
            Rectangle()
                .foregroundStyle(Color(UIColor.systemGray3))
                .alignmentGuide(HorizontalAlignment.playlistCoverImageHorizon.playlistCoverImageAlignment,
                                computeValue: {
                    // 아직 정확한 값 측정 X 추후 계산 후 수정예정
                    d in d[.leading] + 115
                })
                .alignmentGuide(VerticalAlignment.playlistCoverImageVertical.playlistCoverImageAlignment,
                                computeValue: {
                    d in d[.bottom] - 115
                })
                .frame(width: 260, height: 248)
            
            AsyncImage(url: URL(string: coverImageUrl)) { image in
                image
                    .resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 261, height: 253)
        }
        .padding(.bottom, 18)
    }
}

#Preview {
    PlaylistCorverImageView(coverImageUrl: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4")
}
