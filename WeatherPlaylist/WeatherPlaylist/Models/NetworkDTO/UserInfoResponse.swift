//
//  UserInfoResponse.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/11/23.
//

import Foundation
struct UserInfoDTO: Decodable {
    let country, displayName, email, href, id, uri, type, product: String
    let explicitContent: ExplicitContent
    let externalUrls: ExternalUrls
    let followers: Followers
    let images: [ProfileImages]?
    enum CodingKeys: String, CodingKey {
        case country
        case displayName = "display_name"
        case email
        case explicitContent = "explicit_content"
        case externalUrls = "external_urls"
        case followers
        case href
        case id
        case images
        case product
        case type
        case uri
    }
}

// MARK: - ExplicitContent
struct ExplicitContent: Decodable {
    let filterEnabled, filterLocked: Bool
    enum CodingKeys: String, CodingKey {
        case filterEnabled = "filter_enabled"
        case filterLocked = "filter_locked"
    }
}


// MARK: - Followers
struct Followers: Decodable {
    let href: String?
    let total: Int
}
struct ProfileImages: Codable {
    let height: Int?
    let url: String
    let width: Int?
}
