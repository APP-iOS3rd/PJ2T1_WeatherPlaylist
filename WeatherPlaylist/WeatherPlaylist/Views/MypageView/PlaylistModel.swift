//
//  PlaylistModel.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/6/23.
//
import UIKit
import Foundation
#if DEBUG
//MARK: - 임시로 만든 모델
struct PlaylistModel: Identifiable {
    var thumbNail: UIImage?
    var id: String
    var title: String
    var singerList: [String]
    var singerStr: String {
        var str = self.singerList.reduce(""){$0 + ", " + $1}
        str.removeFirst(2)
        return str
    }
}
#endif
