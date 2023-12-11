//
//  PlayMusicModel.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/11/23.
//

import Foundation
import UIKit

struct PlayMusicModel {
    let songName: String
    let artist: String
    let playlistTitle: String
    let coverImage: String
    let songTime: Int

    init(){
        self.songName = "West Coast Love"
        self.artist = "이모셔널 오렌지스"
        self.playlistTitle = "에너지충전 믹스"
        self.coverImage = "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbefacbaef716e41536fab68d4"
        self.songTime = 200
    }
}
