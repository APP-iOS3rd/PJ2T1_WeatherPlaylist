//
//  PlaylistViewModel.swift
//  WeatherPlaylist
//
//  Created by seobe22 on 12/6/23.
//

import Foundation
import Combine

class PlaylistViewModel: ObservableObject {
    @Published var playlistInfo: RecommendedPlayListModel
    @Published var isLoading = false
    @Published var playlist: [PlaylistTrackModel] = []
    private let trackId: String
    private let uid: String
    var player = PlayerManager.shared

    init(playlistInfo: RecommendedPlayListModel, uid: String) {
        self.uid = uid
        self.playlistInfo = playlistInfo
        self.trackId = playlistInfo.id
        fetchIsLiked()
        fetchTracklist()
    }
}

extension PlaylistViewModel {
    func pushAddButton() {
        print("PUSH ADD BUTTON")
    }
    
    func pushPlayButton() {
        if self.player.isPlaying && self.playlistInfo.id == self.player.currentPlaylistID {

            player.pause()
        } else {
            player.playTrackList(tracklist: self.playlist, playlistID: self.playlistInfo.id)
        }
        self.playlistInfo.isPlaying = self.playlistInfo.isPlaying.map{$0 == true ? false : true}
    }
    
    func pushLikeButton() {
        if playlistInfo.isLiked == false {
            let manager = HTTPManager<String?>(apiType: .likePlaylist(id: trackId))
            Task { @MainActor in
                let result = await manager.fetchData()
                switch result {
                case .success(let response) :
                    isLoading = false
                case .failure(let error):
                    print(error.errorDescription)
                    isLoading = false
                }
            }
        } else {
            let manager = HTTPManager<String?>(apiType: .deletePlaylist(id: trackId))
            Task { @MainActor in
                let result = await manager.fetchData()
                switch result {
                case .success(let response) :
                    isLoading = false
                case .failure(let error):
                    print(error.errorDescription)
                    isLoading = false
                }
            }
        }
        self.playlistInfo.isLiked = self.playlistInfo.isLiked.map{$0 == true ? false : true}
    }
    func fetchTracklist() {
        let manager = HTTPManager<TrackListResponse>(apiType: .serchTracks(trackId: trackId))
        Task { @MainActor in
            let result = await manager.fetchData()
            switch result {
            case .success(let response) :
                isLoading = false
                playlist = response.toPlaylistTrackModel.filter { !$0.url.isEmpty }

            case .failure(let error):
                isLoading = false
            }
        }
    }
    func fetchIsLiked() {
        let manager = HTTPManager<[Bool]>(apiType: .userContains(ids: trackId, uid: uid))
        Task { @MainActor in
            let result = await manager.fetchData()
            switch result {
            case .success(let response) :
                isLoading = false
                playlistInfo.isLiked = response.first
            case .failure(let error):
                print(error.errorDescription)
                isLoading = false
            }
        }
    }
    func setPlayerIconWithPlayingState() -> String {
        if self.playlistInfo.id == self.player.currentPlaylistID &&
            self.player.isPlaying {
            return "pause.fill"
        } else {
            return "play.fill"
        }
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
