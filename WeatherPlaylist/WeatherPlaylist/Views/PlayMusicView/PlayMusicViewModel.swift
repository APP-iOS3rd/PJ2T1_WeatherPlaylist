//
//  PlayMusicViewModel.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/11/23.
//

import Foundation
import Combine

final class PlayMusicViewModel: ObservableObject {

    @Published var playMusicModel: PlayMusicModel = .init()
    @Published var playlistModelList: [PlayMusicListModel] = []

    init() {
        fetchModel()
    }
    
    public func fetchModel() {
        self.playMusicModel = .init()
        self.playlistModelList = [
             PlayMusicListModel(songName: "I Like it", 
                                artist: "DeBarage",
                                coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                                songTime: 200),
             PlayMusicListModel(songName: "Instagram",
                                artist: "DEAN",
                                coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                                songTime: 200),
             PlayMusicListModel(songName: "Drama",
                                artist: "aespa",
                                coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                                songTime: 200),
             PlayMusicListModel(songName: "Honesty",
                                artist: "Pionk Sweat$",
                                coverImage: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4",
                                songTime: 200)
         ]
     }

}
