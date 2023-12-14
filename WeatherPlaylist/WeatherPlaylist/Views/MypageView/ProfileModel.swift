//
//  ProfileModel.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/6/23.
//
import UIKit
import Foundation
//MARK: - 임시 프로필 모델
struct ProfileModel {
    let name: String
    let image: URL?
    init() {
        self.name = "닉네임"
        self.image = nil
    }
    init(name: String) {
        self.name = name
        self.image = nil
    }
    init(name: String, image: URL?) {
        self.name = name
        self.image = image
    }
}
