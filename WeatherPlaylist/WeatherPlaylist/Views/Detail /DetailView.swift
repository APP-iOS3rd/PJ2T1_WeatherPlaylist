//
//  DetailView.swift
//  IpodSwiftUI
//
//  Created by 정정욱 on 12/5/23.
//

import SwiftUI

struct DetailView: View {
    
    let thumbnailImage = ["album1", "album2", "album3", "album4"] // API 호출후 삭제예정

    // 화면 그리드형식으로 채워줌
    let thumbnailLayout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    let playlistTrackLayout: [GridItem] = [
        GridItem(.flexible(maximum: 80)),
    ]
    
    var body: some View{
        ScrollView(.vertical) {
            VStack(alignment: .center){
                
                
                // 가로(행) 2줄 설정 (ThumbnailImage View)
                LazyHGrid(rows: thumbnailLayout, spacing: 0) {
                    ForEach(thumbnailImage, id: \.self) { image  in
                        Image(image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                    }
                }
                //ThumbnailImage View end
                
                Text("에너지 충전 슈퍼믹스")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text("당신만의 취향에 맞춰진 신나는 음악과 함께 에너지를 충전하세요.")
                    .font(.caption)
                
                // ButtonView
                HStack(alignment: .center, spacing: 25){
                    Button {
                        print()
                    } label: {
                        Image(systemName:"arrowshape.down.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    
                    Button {
                        print()
                    } label: {
                        Image(systemName:"folder.fill.badge.plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                    
                    Button {
                        print()
                    } label: {
                        Image(systemName:"play.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                    
                    Button {
                        print()
                    } label: {
                        Image(systemName:"arrowshape.turn.up.right.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                    
                    Button {
                        print()
                    } label: {
                        Image(systemName:"arrowshape.down.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                    
                    Button {
                        print()
                    } label: {
                        Image("ellipsis")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }

                }    // ButtonView End
                .offset(x: 30, y: 0)
                .padding(.top)
                .padding(.bottom)
                .foregroundStyle(Color(.red))
                
                // playlistTrackView
                LazyVGrid(columns: playlistTrackLayout, spacing: 5) {
                    ForEach(thumbnailImage, id: \.self) { image  in
                        MusicCell(musicImage: image)
                            .frame(width: 350)
                    }
                }
                // playlistTrackView End
                
            }
        }
    }
}

#Preview {
    DetailView()
}
