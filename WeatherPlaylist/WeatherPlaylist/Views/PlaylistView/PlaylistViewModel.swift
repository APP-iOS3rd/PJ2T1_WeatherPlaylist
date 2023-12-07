//
//  PlaylistViewModel.swift
//  WeatherPlaylist
//
//  Created by seobe22 on 12/6/23.
//

import Foundation

// MARK: 임시 모델
struct PlaylistModel: Identifiable {
    var id: String
    var songName: String
    var artist: String
    var coverImage: String
    var songTime: Int
}

// MARK: 더미 데이터 생성을 위한 클래스
class PlaylistDummyManager {
    var list: [PlaylistModel] = []
    
    init() {
        self.list = setPlaylist()
    }
    
    func setPlaylist() -> [PlaylistModel] {
        return [
            PlaylistModel(id: "aaa",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            PlaylistModel(id: "bbbb",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            PlaylistModel(id: "ccc",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            PlaylistModel(id: "d",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            PlaylistModel(id: "f",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            PlaylistModel(id: "g",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            PlaylistModel(id: "h",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            PlaylistModel(id: "j",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            PlaylistModel(id: "n",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            PlaylistModel(id: "i",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            PlaylistModel(id: "u",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            PlaylistModel(id: "y",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            PlaylistModel(id: "]",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
        ]
    }
}
