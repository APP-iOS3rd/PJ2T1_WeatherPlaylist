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
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal,75)
            CachedImage(url: URL(string: coverImageUrl)) { phase in
                switch phase {
                case .success(let image) :
                    image
                        .resizable()
                case .failure(_), .empty:                 ProgressView()
                }
            }
            .aspectRatio(contentMode: .fit)
            .padding(.horizontal,75)
        }
            .aspectRatio(contentMode: .fit)
        .padding(.bottom, 18)
    }
}

#Preview {
    PlaylistCorverImageView(coverImageUrl: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4")
}
