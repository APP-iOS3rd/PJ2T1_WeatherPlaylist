//
//  UserPlaylistDTO.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/11/23.
//

import Foundation
struct UserPlaylistDTO: Decodable {
    let href: String
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
    let items: [UserPlaylistItem]
}
extension UserPlaylistDTO {
    func toRecommendedPlayListModel() -> [RecommendedPlayListModel]{
        self.items.map { item in
                return .init(id: item.id,
                      playlist: [],
                      weatherType: .rainy,
                      mainTitle: item.name,
                      subitle:  item.description,
                      tracks: URL(string:item.tracks.href),
                      image: item.albumimages.first?.url,
                singers: "가수들")
        }
    }
}
// MARK: - Item
struct UserPlaylistItem: Codable {
    let collaborative: Bool
    let description: String
    let href, id: String
    let externalUrls: ExternalUrls
    let albumimages: [AlbumImage]
    let name: String
    let owner: Owner
    let itemPublic: Bool
    let snapshotID: String
    let tracks: Tracks
    let type, uri: String

    enum CodingKeys: String, CodingKey {
        case collaborative, description
        case externalUrls = "external_urls"
        case href, id, name, owner
        case itemPublic = "public"
        case snapshotID = "snapshot_id"
        case albumimages = "images"
        case tracks, type, uri
    }
}


