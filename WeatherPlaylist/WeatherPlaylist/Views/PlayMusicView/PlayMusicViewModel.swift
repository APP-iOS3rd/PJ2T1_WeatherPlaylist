//
//  PlaymusicViewModel.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/11/23.
//

import Foundation
import Combine

final class PlayMusicViewModel: ObservableObject {
     
    @Published var playMusicModel: PlayMusicModel = .init()
    
    @Published var playlistModelList: [PlayMusicListModel] = []
    
    init(){
        fetchModel()
    }
    private func fetchModel(){
        self.playMusicModel = .init()
        
        self.playlistModelList = [
            PlayMusicListModel(title: "I Like it", artist: "DeBarage",imgURL: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4"),
            PlayMusicListModel(title: "Instagram", artist: "DEAN", imgURL: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4"),
            PlayMusicListModel(title: "Drama", artist: "aespa", imgURL: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4"),
            PlayMusicListModel(title: "Honesty", artist: "Pionk Sweat$", imgURL: "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4")
        ]
    }
 
}
