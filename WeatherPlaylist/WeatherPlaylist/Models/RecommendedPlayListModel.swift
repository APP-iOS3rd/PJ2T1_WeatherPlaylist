//
//  RecommendedModel.swift
//  WeatherPlaylist
//
//  Created by 정정욱 on 12/7/23.
//


import Foundation

// MARK: 임시 모델

struct RecommendedPlayListModel: Identifiable, Hashable {
    var id: String
    var playlist: [MusicModel]
    var mainTitle: String
    var subitle: String
    var tracks: URL?
    var image: String?
    var singers: String?
    var isLiked: Bool?
    var isPlaying: Bool?
}
