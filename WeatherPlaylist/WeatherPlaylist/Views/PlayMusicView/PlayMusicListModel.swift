//
//  PlayMusicListModel.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/11/23.
//

import Foundation
import UIKit
// 현재 재생목록
struct PlayMusicListModel: Identifiable{
    var id = UUID()
    var songName: String
    var artist: String
    var coverImage: String
    var songTime: Int
}
