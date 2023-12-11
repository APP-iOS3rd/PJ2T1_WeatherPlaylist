//
//  PlaylistModel.swift
//  WeatherPlaylist
//
//  Created by seobe22 on 12/7/23.
//

import Foundation

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

//struct PlayListInfo {
//    var playlistName: String
//    var playlistDescription: String
//    var coverImageUrl: String
//    var isLikePlaylist: Bool
//    var isPlaying = false
//}
