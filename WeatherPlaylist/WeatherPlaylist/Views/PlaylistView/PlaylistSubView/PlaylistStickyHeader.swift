//
//  PlaylistStickyHeader.swift
//  WeatherPlaylist
//
//  Created by seobe22 on 12/6/23.
//

import SwiftUI

struct PlaylistStickyHeader: View {
    @EnvironmentObject var viewModel: PlaylistViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .center, spacing: 6) {
                Text(viewModel.playlistInfo.playlistName)
                    .font(.appFont(for: .Bold, size: 22))
                
                Text(viewModel.playlistInfo.playlistDescription)
                    .font(.light10)
            }
            .padding(.bottom, 32)
            
            // MARK: + 버튼, 재생 버튼, 좋아요 버튼 순
            PlaylistControllerView()
                .environmentObject(viewModel)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Rectangle().foregroundStyle(.white))
        .padding(.bottom, 16)
    }
}

//#Preview {
//    PlaylistStickyHeader(playlistInfo: .init(playlistName: "에너지 충전 슈퍼믹스",
//                                             playlistDescription: "당신만의 취향에 맞춰진 신나는 음악과 함께 에너지를 충전하세요.",
//                                             coverImageUrl: "",
//                                             isLikePlaylist: false))
//}
