//
//  MainPageViewModel.swift
//  WeatherPlaylist
//
//  Created by 정정욱 on 12/7/23.
//

import Foundation
import Combine

final class MainPageViewModel: ObservableObject {
    
    @Published var recommendedModelList: [RecommendedPlayListModel] = []
    @Published var weatherData = WeatherAPI.shared
    
    @Published var profileURL: URL? = nil
    @Published var uid: String = ""
    @Published var isLoading: Bool = false

   
    init() {
        settingWeatherData() //💁 초기 사용자 위치를 이용하여 필수 날씨 상태 정보, 쿼리 값 셋팅
        WeatherAPI.shared.delegate = self
    }

    func settingWeatherData() {
        let locationManager = LocationManager()
        locationManager.startUpdatingLocation()
        print("위도: \(locationManager.latitude), 경도: \(locationManager.longitude)")
      
        // 사용자 위도, 경도를 전달하여 API 호출
        weatherData.feachWeatherData(lat: locationManager.latitude, lon: locationManager.longitude)
        
    }
    
    //💁 쿼리 값 셋팅 이후 델리게이트 메서드(didUpdateSpotifyRandomQuery) 실행
    // 올바른 쿼리 값 담긴다면 의존성 있는 메서드를 실행
    var spotifyQuery: String = "" {
        didSet {
            // 대입되는 순간 문제 query값의 의존하는 메서드들을 실행
            self.fetchPlayListModel() // SpotifyAPI호출
            self.fetchRecommendedList() // 요청에 맞는 플레이리스트 가져오기
        }
    }
   
    

    
    private func fetchRecommendedList() {
        self.recommendedModelList = RecommendedModelManager().recommendedPlayList
    }

    func fetchPlayListModel() {
        let manager: HTTPManager<SearchResponse> = HTTPManager<SearchResponse>(apiType: .serchPlaylist(query: spotifyQuery))
        Task { @MainActor in

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
                uid = response.id
                guard let imgURL = response.images?.min()?.url else {return}
                profileURL = URL(string: imgURL)
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
                default:
                    print(error.errorDescription)
                }
            }
        }
    }  
    
    
}

extension MainPageViewModel: WeatherAPIDelegate{
    func didUpdateSpotifyRandomQuery(_ query: String) {
        // 올바른 쿼리 값을 받아오게 구현
        self.spotifyQuery = self.weatherData.spotifyRandomQuery
    }
}

