//
//  BadgeModel.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/12/23.
//

import Foundation

struct BadgeModel: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var isCheck: Bool
}
