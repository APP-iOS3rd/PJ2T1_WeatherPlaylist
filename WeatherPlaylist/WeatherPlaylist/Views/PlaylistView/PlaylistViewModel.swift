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
    @Published var playlistInfo: RecommendedPlayListModel
    @Published var isLoading = false
    @Published var playlist: [PlaylistTrackModel] = []
    private let trackId: String
    init(playlistInfo: RecommendedPlayListModel) {
        self.playlistInfo = playlistInfo
        self.trackId = playlistInfo.id
        fetchIsLiked()
        fetchTracklist()
        fetchTrackModel()
    }
}

extension PlaylistViewModel {
    func pushAddButton() {
        print("PUSH ADD BUTTON")
    }
    
    func pushPlayButton() {
        self.playlistInfo.isPlaying = self.playlistInfo.isPlaying.map{$0 == true ? false : true}
    }
    
    func pushLikeButton() {
        self.playlistInfo.isLiked = self.playlistInfo.isLiked.map{$0 == true ? false : true}
    }
    func fetchTracklist() {
        let manager = HTTPManager<TrackListResponse>(apiType: .serchTracks(trackId: trackId))
        Task { @MainActor in
            let result = await manager.fetchData()
            switch result {
            case .success(let response) :
                isLoading = false
                playlist = response.toPlaylistTrackModel
            case .failure(let error):
                isLoading = false
            }
        }
    }
    func fetchIsLiked() {
        let manager = HTTPManager<[Bool]>(apiType: .userContains(ids: trackId))
        Task { @MainActor in
            let result = await manager.fetchData()
            switch result {
            case .success(let response) :
                isLoading = false
               dump(response)
            case .failure(let error):
                print(error.errorDescription)
                isLoading = false
            }
        }
    }
    func fetchTrackModel() {
        self.playlist = [
            PlaylistTrackModel(id: "aaa",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            PlaylistTrackModel(id: "bbbb",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            PlaylistTrackModel(id: "ccc",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            PlaylistTrackModel(id: "d",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            PlaylistTrackModel(id: "f",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            PlaylistTrackModel(id: "g",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            PlaylistTrackModel(id: "h",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            PlaylistTrackModel(id: "j",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            PlaylistTrackModel(id: "n",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            PlaylistTrackModel(id: "i",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            PlaylistTrackModel(id: "u",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            PlaylistTrackModel(id: "y",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
            PlaylistTrackModel(id: "]",
                          songName: "title",
                          artist: "artist",
                          coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                          songTime: 200),
        ]
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
