//
//  SearchResponse.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/11/23.
//

import Foundation
// MARK: - SearchResponse
struct SearchResponse: Codable {
    let playlists: Playlists
}

extension SearchResponse {
    func toRecommendedPlayListModel() -> [RecommendedPlayListModel]{
        self.playlists.items.map { item in
                .init(id: item.id,
                      playlist: [],
                      weatherType: .rainy,
                      mainTitle: item.name,
                      subitle:  item.description,
                      tracks: URL(string:item.tracks.href),
                      image: item.albumimages.first?.url)
        }
    }
}
// MARK: - Playlists
struct Playlists: Codable {
    let href: String
    let items: [Items]
    let limit: Int
    let next: String
    let offset: Int
    let previous: String?
    let total: Int
}

// MARK: - Item
struct Items: Codable {
    let collaborative: Bool
    let description: String
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let albumimages: [AlbumImage]
    let name: String
    let owner: Owner
//    let primaryColor, itemPublic: JSONNull?
    let snapshotID: String
    let tracks: Tracks
    let type, uri: String

    enum CodingKeys: String, CodingKey {
        case collaborative, description
        case externalUrls = "external_urls"
        case href, id, name, owner
        case snapshotID = "snapshot_id"
        case albumimages = "images"
        case tracks, type, uri
    }
}

// MARK: - ExternalUrls
struct ExternalUrls: Codable {
    let spotify: String
}

// MARK: - Image
struct AlbumImage: Codable {
    let height: Int?
    let url: String
    let width: Int?
}

// MARK: - Owner
struct Owner: Codable {
    let displayName: String
    let externalUrls: ExternalUrls
    let href: String
    let id, type, uri: String

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case externalUrls = "external_urls"
        case href, id, type, uri
    }
}

// MARK: - Tracks
struct Tracks: Codable {
    let href: String
    let total: Int
}
