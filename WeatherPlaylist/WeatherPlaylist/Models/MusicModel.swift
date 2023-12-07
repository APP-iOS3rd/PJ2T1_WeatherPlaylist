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
}
// MARK: 더미 데이터 생성을 위한 클래스
class MusicListDummyManager {
    var list: [MusicModel] = []
    
    init() {
        self.list = fetchPlaylist()
    }
    
    func fetchPlaylist() -> [MusicModel] {
        return [
            MusicModel(id: "aaa",
                          songName: "가가가",
                          artist: "가가가가",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            MusicModel(id: "bbbb",
                          songName: "나나나",
                          artist: "나나나나",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            MusicModel(id: "ccc",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            MusicModel(id: "d",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            MusicModel(id: "f",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            MusicModel(id: "g",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            MusicModel(id: "h",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            MusicModel(id: "j",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            MusicModel(id: "n",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            MusicModel(id: "i",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            MusicModel(id: "u",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            MusicModel(id: "y",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            MusicModel(id: "]",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
        ]
    }
}
