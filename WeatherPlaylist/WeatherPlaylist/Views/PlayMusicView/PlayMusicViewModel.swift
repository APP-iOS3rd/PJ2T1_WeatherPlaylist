//
//  PlayMusicViewModel.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/11/23.
//

import Foundation
import Combine
final class PlayMusicViewModel: ObservableObject {
    
    @Published var playMusicModel: PlayMusicListModel = .empty
    @Published var playlistModelList: [PlayMusicListModel] = []
    @Published var isPlaying: Bool = false
    private var index: Int = 0
    
    init() {
        fetchModel()
        HapticManager.shared.setupGenerator()
    }
    init(playlistURL: String) {
        fetchModel()
        HapticManager.shared.setupGenerator()
    }
    deinit {
        HapticManager.shared.release()
    }
}
//MARK: - fetch 로직
extension PlayMusicViewModel {
    public func fetchModel() {
        self.playlistModelList = [
             PlayMusicListModel(songName: "I Like it", 
                                playlistTitle: "에너지충전 믹스", artist: "DeBarage",
                                coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                                songTime: 200),
             PlayMusicListModel(songName: "Instagram",
                                playlistTitle: "에너지충전 믹스", artist: "DEAN",
                                coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                                songTime: 200),
             PlayMusicListModel(songName: "Drama",
                                playlistTitle: "에너지충전 믹스", artist: "aespa",
                                coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                                songTime: 200),
             PlayMusicListModel(songName: "Honesty",
                                playlistTitle: "에너지충전 믹스", artist: "Pionk Sweat$",
                                coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                                songTime: 200)
         ]
        if !playlistModelList.isEmpty {
            self.playMusicModel = self.playlistModelList[index]
        }
     }

}
//MARK: - 뷰바인딩 로직
extension PlayMusicViewModel {
    func pauseAndPlay() {
        HapticManager.shared.createImpact()
        self.isPlaying.toggle()
        
    }
    func previousSong() {
        //자동 재생
        HapticManager.shared.createImpact()

        if index == 0 {
            index = self.playlistModelList.count - 1
        } else {
            index -= 1
        }
        self.isPlaying = true
        if !playlistModelList.isEmpty {
            self.playMusicModel = self.playlistModelList[index]
        }
    }
    func nextSong() {
        HapticManager.shared.createImpact()

        //자동 재생
        if index == self.playlistModelList.count - 1 {
            index = 0
        } else {
            index += 1
        }
        self.isPlaying = true
        if !playlistModelList.isEmpty {
            self.playMusicModel = self.playlistModelList[index]
        }
    }
}
