//
//  RecommendedModel.swift
//  WeatherPlaylist
//
//  Created by 정정욱 on 12/7/23.
//


import Foundation

// MARK: 임시 모델

struct RecommendedPlayListModel: Identifiable, Hashable {
    var id: String
    var playlist: [MusicModel]
    var weatherType: WeatherType
    var mainTitle: String
    var subitle: String
    var tracks: URL?
    var image: String?
}

// MARK: 더미 데이터 생성을 위한 클래스
class RecommendedModelManager {
    var recommendedPlayList: [RecommendedPlayListModel] = []
    
    init() {
        self.recommendedPlayList = fetchPlaylist()
    }
    
    func fetchPlaylist() -> [RecommendedPlayListModel] {
        return [
            RecommendedPlayListModel(id: "aaa",
                             playlist: MusicListDummyManager().list,
                             weatherType: .rainy,
                             mainTitle: "비오는 날엔 R&B 어때요?",
                             subitle: "추천 리스트"),
            RecommendedPlayListModel(id: "bbb",
                             playlist: MusicListDummyManager().list,
                             weatherType: .rainy,
                             mainTitle: "비오는 날엔 비오",
                             subitle: "추천 리스트"),
            RecommendedPlayListModel(id: "ccc",
                             playlist: MusicListDummyManager().list,
                             weatherType: .rainy,
                             mainTitle: "비 오는 날엔 눈물을 흘려",
                             subitle: "추천 리스트"),
            RecommendedPlayListModel(id: "ddd",
                             playlist: MusicListDummyManager().list,
                             weatherType: .rainy,
                             mainTitle: "비 오는 날엔 눈물을 흘려",
                             subitle: "추천 리스트"),
            RecommendedPlayListModel(id: "eee",
                             playlist: MusicListDummyManager().list,
                             weatherType: .snowy,
                             mainTitle: "눈오는 날엔 이 노래 어때요?",
                             subitle: "추천 리스트"),
            RecommendedPlayListModel(id: "fff",
                             playlist: MusicListDummyManager().list,
                             weatherType: .snowy,
                             mainTitle: "눈오는 날엔 춤을 춰",
                             subitle: "추천 리스트"),
            RecommendedPlayListModel(id: "ggg",
                             playlist: MusicListDummyManager().list,
                             weatherType: .snowy,
                             mainTitle: "눈사람 만들때 듣는 노래",
                             subitle: "추천 리스트"),
            RecommendedPlayListModel(id: "hhh",
                             playlist: MusicListDummyManager().list,
                             weatherType: .snowy,
                             mainTitle: "눈오는 날엔 이 노래 어때요?",
                             subitle: "추천 리스트"),
           
        ]
    }
}
