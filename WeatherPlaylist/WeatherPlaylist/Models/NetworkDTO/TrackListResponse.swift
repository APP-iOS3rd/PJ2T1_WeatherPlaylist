//
//  TrackListResponse.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/12/23.
//

import Foundation

// MARK: - TrackListResponse
struct TrackListResponse: Codable {
    let total: Int
    let items: [TrackItem]
    var toPlaylistTrackModel: [PlaylistTrackModel] {
        self.items.map{ track in
            var temp = track.track.artists.reduce(""){ $0 + $1.name + ", "}
            temp.removeLast() // 공백제거
            temp.removeLast() // 콤마제거
               return .init(id: track.track.id,
                      songName: track.track.name,
                      artist: temp,
                      coverImage: track.track.album.images.min()?.url ?? "",
                      songTime: track.track.durationMS)
        }
    }
}

// MARK: - Item
struct TrackItem: Codable {
    let addedAt: String
    let track: Track
    enum CodingKeys: String, CodingKey {
        case addedAt = "added_at"
        case track
    }
}

// MARK: - Track
struct Track: Codable {
    let id: String
    let album: Album
    let artists: [Artist]
    let discNumber, durationMS: Int
    let track: Bool?
    let explicit: Bool
    let externalIDS: ExternalIDS
    let externalUrls: ExternalUrls
    let isPlayable: Bool
    let name: String
    let popularity: Int?
    let previewURL: String?
    let trackNumber: Int
    let type, uri: String
    let isLocal: Bool

    enum CodingKeys: String, CodingKey {
        case album, artists
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
        case externalIDS = "external_ids"
        case externalUrls = "external_urls"
        case isPlayable = "is_playable"
        case name, popularity
        case previewURL = "preview_url"
        case trackNumber = "track_number"
        case type, uri
        case isLocal = "is_local"
        case track
        case id
    }
}

// MARK: - Album
struct Album: Codable {
    let albumType: String
    let totalTracks: Int
    let externalUrls: ExternalUrls
    let isPlayable: Bool
    let images: [ProfileImages]
    let name, releaseDate, releaseDatePrecision: String
    let type, uri: String
    let artists: [Artist]

    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case totalTracks = "total_tracks"
        case externalUrls = "external_urls"
        case images, name
        case isPlayable = "is_playable"
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case type, uri, artists
    }
}

// MARK: - Artist
struct Artist: Codable {
    let externalUrls: ExternalUrls
    let images: [AlbumImage]?
    let name: String
    let type, uri: String

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case images, name, type, uri
    }
}

// MARK: - ExternalIDS
struct ExternalIDS: Codable {
    let isrc, ean, upc: String?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
