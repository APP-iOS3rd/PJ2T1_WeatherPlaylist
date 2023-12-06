//
//  View.swift
//  WeatherPlaylist
//
//  Created by seobe22 on 12/6/23.
//

import SwiftUI

extension HorizontalAlignment {
    enum playlistCoverImageHorizon: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[HorizontalAlignment.center]
        }
        static let playlistCoverImageAlignment = HorizontalAlignment(playlistCoverImageHorizon.self)
    }
}

extension VerticalAlignment {
    enum playlistCoverImageVertical: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[VerticalAlignment.center]
        }
        static let playlistCoverImageAlignment = VerticalAlignment(playlistCoverImageVertical.self)
    }
}

extension Alignment {
    static let playlistCoverImageAlignment = Alignment(horizontal: .playlistCoverImageHorizon.playlistCoverImageAlignment, vertical: .playlistCoverImageVertical.playlistCoverImageAlignment)
}

struct PlaylistView: View {
    var playlistName: String
    var playlistDescription: String
    var coverImageUrl: String
    var isLikePlaylist: Bool
    
    var body: some View {
        VStack{
            ZStack(alignment: .playlistCoverImageAlignment) {
                Rectangle()
                    .foregroundStyle(.gray)
                    .alignmentGuide(HorizontalAlignment.playlistCoverImageHorizon.playlistCoverImageAlignment, computeValue: { d in
                        d[.leading] + 120
                    })
                    .alignmentGuide(VerticalAlignment
                        .playlistCoverImageVertical
                        .playlistCoverImageAlignment, computeValue: { d in
                            d[.bottom] - 115
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
            .frame(width:281, height: 262)
            .padding(.bottom, 18)
            
            VStack(alignment: .center, spacing: 6) {
                Text(playlistName)
                    .font(.system(size: 22))
                    .font(.title)
                
                Text(playlistDescription)
                    .font(.system(size: 10))
                    .font(.body)
            }
            .padding(.bottom, 32)
            
            PlayControllerView(isLikePlaylist: isLikePlaylist)
        }
        .padding(.top, 39)
        Spacer()
    }
}
