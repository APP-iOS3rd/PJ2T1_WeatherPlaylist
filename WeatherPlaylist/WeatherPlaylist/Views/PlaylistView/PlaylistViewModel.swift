//
//  PlaylistViewModel.swift
//  WeatherPlaylist
//
//  Created by seobe22 on 12/6/23.
//

import Foundation

// MARK: 임시 모델

import Combine

class PlaylistViewModel: ObservableObject {
    @Published var playlistInfo: PlayListInfo = .init(playlistName: "",
                                                      playlistDescription: "",
                                                      coverImageUrl: "",
                                                      isLikePlaylist: false,
                                                      isPlaying: false
    )
    @Published var playlist: [PlaylistTrackModel] = []
    @Published var player = PlayerManager.shared
    
    init() {
        fetchTrackModel()
        fetchInfoModel()
    }
}

extension PlaylistViewModel {
    func pushAddButton() {
        print("PUSH ADD BUTTON")
        player.goPrevTrack()
    }
    
    func pushPlayButton() {
//        if player.player.items().isEmpty {
//            player.play()
//        } else {
//            player.pause()
//        }
        if self.playlistInfo.isPlaying {
            player.pause()
        } else {
            player.playTrackList(tracklist: self.playlist)
        }
        self.playlistInfo.isPlaying.toggle()
    }
    
    func pushLikeButton() {
        self.playlistInfo.isLikePlaylist.toggle()
        player.goNextTrack()
    }
    
    func fetchTrackModel() {
        self.playlist = [
            PlaylistTrackModel(id: "aaa",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200,
                               url: "https://p.scdn.co/mp3-preview/c7e343a6d61268bc9aecaa38e1f599b56585e49d?cid=6a6481d46d474cafad6d5e5076fe7c9f"
                              ),
            PlaylistTrackModel(id: "bbbb",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200,
                               url: "https://p.scdn.co/mp3-preview/d8c6c428ba0f391d790a281b4c650979952e7fc3?cid=6a6481d46d474cafad6d5e5076fe7c9f"
                              ),
            PlaylistTrackModel(id: "ccc",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200,
                               url: "https://p.scdn.co/mp3-preview/172fb14faed42a264050b4baf95ae6cd434a1058?cid=6a6481d46d474cafad6d5e5076fe7c9f"),
            PlaylistTrackModel(id: "d",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200,
                               url: "https://p.scdn.co/mp3-preview/fa0df182b53106c2ce6987971dc91f394477b876?cid=6a6481d46d474cafad6d5e5076fe7c9f"),
            PlaylistTrackModel(id: "f",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200,
                               url: "https://p.scdn.co/mp3-preview/9ccce944caa6e4aefb8f896c2f16ef1e8c77af37?cid=6a6481d46d474cafad6d5e5076fe7c9f"),
        ]
    }
    
    func fetchInfoModel() {
        self.playlistInfo = .init(playlistName: "제목",
                                  playlistDescription: "플리 설명",
                                  coverImageUrl: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                                  isLikePlaylist: false)
    }
}


// MARK: 더미 데이터 생성을 위한 클래스
class PlaylistDummyManager {
    var list: [PlaylistModel] = []
    
    init() {
        
        self.list = fetchPlaylist()
    }
    
    func fetchPlaylist() -> [PlaylistModel] {
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
