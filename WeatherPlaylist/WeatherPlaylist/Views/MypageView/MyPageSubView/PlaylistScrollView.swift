//
//  PlaylistScrollView.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/6/23.
//

import Foundation
import SwiftUI
struct PlaylistScrollView: View {
    @EnvironmentObject var viewModel: ProfileViewModel
    @State var title: String
    var body: some View {
        VStack {
            HStack {
                Text(title)
                Spacer()
            }.padding(.leading, 25)
                .padding(.top, 50)
                .padding(.bottom,-10)
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(viewModel.playlistModelList) { model in
                        VStack(alignment:.leading) {
                            Image(uiImage: model.thumbNail ?? .emptyImg)
                                .resizable()
                                .frame(width: 100,height: 100)
                            Text(model.title)
                            Text(model.singerStr)
                                .lineLimit(1)
                        }.frame(width: 100)
                        .padding(.vertical,20)
                        .padding(.horizontal,10)
                    }
                }
            }.padding(.leading, 25)
                .frame(width: UIScreen.main.bounds.width)
                .aspectRatio(contentMode: .fit)
        }
    }
}
#Preview {
    PlaylistScrollView(title: "저장한 플레이리스트")
        .environmentObject(ProfileViewModel())
}
