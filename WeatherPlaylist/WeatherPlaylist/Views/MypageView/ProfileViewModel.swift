//
//  ProfileViewModel.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/6/23.
//

import Foundation
import Combine

final class ProfileViewModel: ObservableObject {
    @Published var playlistModelList: [PlaylistModel] = []
    @Published var profileModel: ProfileModel = .init()
    init() {
        fetchModel()
    }
    //MARK: - fetch 로직 구현 전 임시 함수
    private func fetchModel() {
        self.playlistModelList = [PlaylistModel(id: "1",
                                                title: "즐거운 믹스",
                                                singerList: ["슈퍼비", "디핵", "기리보이", "기타등등"]),
                                  PlaylistModel(id: "2",
                                                         title: "즐거운 믹스",
                                                        singerList: ["슈퍼비", "디핵", "기리보이", "기타등등"]),
                                  PlaylistModel(id: "3",
                                                         title: "즐거운 믹스",
                                                singerList: ["슈퍼비", "디핵", "기리보이", "기타등등"]),
                                  PlaylistModel(id: "4",
                                                         title: "즐거운 믹스",
                                                singerList: ["슈퍼비", "디핵", "기리보이", "기타등등"])
                         ]
        self.profileModel = .init(name: "김나무")
    }    
}
