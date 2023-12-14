//
//  PlaylistViewModel.swift
//  WeatherPlaylist
//
//  Created by seobe22 on 12/6/23.
//

import Foundation

// MARK: 임시 모델
struct MusicModel: Identifiable, Hashable {
    var id: String
    var songName: String
    var artist: String
    var coverImage: String
    var songTime: Int
}
struct PlayListInfo {
    var playlistName: String
    var playlistDescription: String
    var coverImageUrl: String
    var isLikePlaylist: Bool
    var isPlaying = false
}
