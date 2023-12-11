//
//  PlaylistModel.swift
//  WeatherPlaylist
//
//  Created by seobe22 on 12/7/23.
//

import Foundation

// PlaylistModel을 PlaylistTrackModel로 변경하였습니다.
// 다른 곳에서 PlaylistModel을 사용하는 곳이 있을 수 있어 일단 두 가지 모두 살려두었습니다.
struct PlaylistTrackModel: Identifiable, Hashable {
    var id: String
    var songName: String
    var artist: String
    var coverImage: String
    var songTime: Int
}

struct PlaylistModel: Identifiable, Hashable {
    var id: String
    var songName: String
    var artist: String
    var coverImage: String
    var songTime: Int
}

// 현재 Playlist의 재생상태를 나타내는 isPlaying 프로퍼티를 추가하였습니다.
struct PlayListInfo {
    var playlistName: String
    var playlistDescription: String
    var coverImageUrl: String
    var isLikePlaylist: Bool
    var isPlaying = false
}
