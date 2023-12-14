//
//  PlayMusicListModel.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/11/23.
//

import Foundation
import UIKit
// 현재 재생목록
struct PlayMusicListModel: Identifiable{
    var id = UUID()
    var songName: String
    var playlistTitle: String
    var artist: String
    var coverImage: String
    var songTime: Int
    init(id: UUID = UUID(), songName: String,playlistTitle: String, artist: String, coverImage: String, songTime: Int) {
        self.id = id
        self.songName = songName
        self.playlistTitle = playlistTitle
        self.artist = artist
        self.coverImage = coverImage
        self.songTime = songTime
    }
    static var empty: PlayMusicListModel{
        .init(songName: "재생 중인 노래가 없습니다", playlistTitle: "빈 플레이리스트", artist: "빈 아티스트", coverImage: "", songTime: 0)
    }
}
