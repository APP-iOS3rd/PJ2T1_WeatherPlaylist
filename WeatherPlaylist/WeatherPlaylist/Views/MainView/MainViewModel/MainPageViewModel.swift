//
//  MainPageViewModel.swift
//  WeatherPlaylist
//
//  Created by 정정욱 on 12/7/23.
//

import Foundation
import Combine

final class MainPageViewModel: ObservableObject {
    
    // ViewModel은 RecommendedModel을 가지고 있음
    
    //@Published var playlistModelList: [MusicModel] = []
    
    @Published var recommendedModelList: [RecommendedPlayListModel] = []
    
    init() {
     //   fetchModel()
        fetchRecommendedList()
    }
    //MARK: - fetch 로직 구현 전 임시 함수
//    private func fetchModel() {
//        self.playlistModelList = MusicListDummyManager().list
//    }
    
    private func fetchRecommendedList() {
        self.recommendedModelList = RecommendedModelManager().recommendedPlayList
    }
    
    
    
}


