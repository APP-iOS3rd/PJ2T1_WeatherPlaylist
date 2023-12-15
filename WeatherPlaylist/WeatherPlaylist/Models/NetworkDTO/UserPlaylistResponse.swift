//
//  UserPlaylistResponse.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/11/23.
//

import Foundation
struct UserPlaylistResponse: Decodable {
    let href: String
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
    let items: [Items]
}
extension UserPlaylistResponse {
    func toRecommendedPlayListModel() -> [RecommendedPlayListModel]{
        self.items.map { item in
                return .init(id: item.id,
                      playlist: [],
                      mainTitle: item.name,
                      subitle:  item.description,
                      tracks: URL(string:item.tracks.href),
                      image: item.albumimages.first?.url,
                singers: "가수들")
        }
    }
    
    var tracklist: [String] {
        self.items.map{$0.id}
    }
}
