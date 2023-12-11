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
    var title: String
    var artist: String
    var imgURL: String
}
