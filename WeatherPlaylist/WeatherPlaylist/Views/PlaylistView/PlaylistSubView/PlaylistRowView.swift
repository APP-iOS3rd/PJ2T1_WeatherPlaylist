//
//  PlaylistRowView.swift
//  WeatherPlaylist
//
//  Created by seobe22 on 12/6/23.
//

import SwiftUI

struct PlaylistRowView: View {
    var id: String
    var songName: String
    var artist: String
    var coverImage: String
    var songTime: Int
    
    var body: some View {
        // MARK: 이미지 임시 구성
        HStack() {
            AsyncImage(url: URL(string: coverImage)) { image in
                image
                    .resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 48, height: 48)
            .padding(.trailing, 24)
            
            VStack(alignment: .leading) {
                Text(songName)
                    .font(.system(size: 16, weight: .bold))
                HStack {
                    Text(artist)
                        .font(.system(size: 14, weight: .light))
                    Text(changeTimeIntToString(songTime))
                        .font(.system(size: 14, weight: .light))
                }
            }
            Spacer()
        }
    }
    
    func changeTimeIntToString(_ time: Int) -> String {
        let minite = time / 60
        let tempSecond = time % 60
        let second = tempSecond >= 10 ? String(tempSecond) : (String(tempSecond) + "0")
        return "\(minite):\(second)"
    }
}
