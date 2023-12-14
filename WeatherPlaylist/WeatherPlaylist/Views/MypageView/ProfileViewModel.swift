//
//  ProfileViewModel.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/6/23.
//

import Foundation
import Combine

final class ProfileViewModel: ObservableObject {
    @Published var playlistModelList: [RecommendedPlayListModel] = []
    @Published var profileModel: ProfileModel = .init()
    @Published var isLoading: Bool = false
    @Published var uid: String = ""
    private let manager = HTTPManager<UserInfoDTO>(apiType: .getUserInfo)
    private let userPlaylistManager = HTTPManager<UserPlaylistResponse>(apiType: .getUsersPlayList)
    init() {
        fetchModel()
        fetchUserPlaylistModel()
    }
}
//MARK: - fetch 로직
extension ProfileViewModel {
    func refresh() {
        fetchModel()
        fetchUserPlaylistModel()
    }
    private func fetchModel() {
        isLoading = true
        Task { @MainActor in
            let result = await manager.fetchData()
            switch result {
            case .success(let response) :
                isLoading = false
                self.uid = response.id
                guard let imgURL = response.images?.map({$0.url}).first else {return}
                profileModel = .init(name: response.displayName, image: URL(string: imgURL))
            case .failure(let error):
                isLoading = false
            }
        }
    }
    private func fetchUserPlaylistModel() {
        isLoading = true

        Task { @MainActor in
            let result = await userPlaylistManager.fetchData()
            switch result {
            case .success(let response) :
                isLoading = false
                self.playlistModelList = response.toRecommendedPlayListModel()
            case .failure(let error):
                isLoading = false
            }
        }
    }
}
