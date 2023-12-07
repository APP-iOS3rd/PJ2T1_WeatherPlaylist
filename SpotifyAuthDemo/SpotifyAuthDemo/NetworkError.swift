//
//  NetworkError.swift
//  SpotifyAuthDemo
//
//  Created by 김성엽 on 12/7/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidServerResponse
    case generalError
}
