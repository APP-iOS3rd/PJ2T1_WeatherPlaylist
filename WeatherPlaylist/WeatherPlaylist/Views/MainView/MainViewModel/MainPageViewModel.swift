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
    @Published var profileURL: URL? = nil
    @Published var isLoading: Bool = false

    private let profileManager = HTTPManager<UserInfoDTO>(apiType: .getUserInfo)
    private let manager = HTTPManager<SearchResponse>(apiType: .serchPlaylist(query: "nice"))

    init() {
     //   fetchModel()
        fetchRecommendedList()
        fetchPlayListModel()
        fetchProfile()
        
    }
    //MARK: - fetch 로직 구현 전 임시 함수
//    private func fetchModel() {
//        self.playlistModelList = MusicListDummyManager().list
//    }
    
    private func fetchRecommendedList() {
        self.recommendedModelList = RecommendedModelManager().recommendedPlayList
    }
    func fetchPlayListModel() {
        isLoading = true

        Task{ @MainActor in
            let response = await manager.fetchData()
            switch response {
            case .success(let data):
                self.recommendedModelList = data.toRecommendedPlayListModel()
                print(data.playlists.items.first?.tracks.href)
                data.playlists.items.map{$0.tracks.href}
                isLoading = false

            case .failure(let error):
                switch error {
                case .httpError(let httpError) :
                    switch httpError {
                    case .authError :
                        print("로그아웃됨")
                    default:
                        print(error.errorDescription)
                    }
                    isLoading = false

                default:
                    print(error.errorDescription)
                    isLoading = false

                }
            }
        }
    }
    private func fetchProfile() {

        Task { @MainActor in
            let result = await profileManager.fetchData()
            switch result {
            case .success(let response) :
                guard let imgURL = response.images?.min()?.url else {return}
                profileURL = URL(string: imgURL)
                isLoading = false

            case .failure(let error):
                print(error.errorDescription)
                isLoading = false

            }
        }
    }
    
    
    
}


