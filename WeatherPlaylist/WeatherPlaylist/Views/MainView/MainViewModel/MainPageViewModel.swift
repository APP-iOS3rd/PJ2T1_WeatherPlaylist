// MainPageViewModel.swift
// WeatherPlaylist
//
// Created by 정정욱 on 12/7/23.

import Foundation
import Combine

final class MainPageViewModel: ObservableObject {

    // 여러 쿼리를 던지고 각각 쿼리에 따라 리스트를 담을 배열
    var recommendedModelList: [[RecommendedPlayListModel]] = []
    // 쿼리 중 랜덤으로 mainViewTitle을 지정
    @Published var mainViewTitle: String = ""
    
    @Published var weatherData = WeatherAPI.shared
    @Published var profileURL: URL? = nil
    @Published var uid: String = ""
    
    // 데이터가 로딩 중인지 파악 true 되어야 MainView가 열릴 수 있음
    @Published var isLoading: Bool = false
    private let profileManager = HTTPManager<UserInfoDTO>(apiType: .getUserInfo)

    init() {
        settingWeatherData()
        WeatherAPI.shared.delegate = self
    }

    func settingWeatherData() {
        let locationManager = LocationManager()
        locationManager.startUpdatingLocation()
        print("위도: \(locationManager.latitude), 경도: \(locationManager.longitude)")
        
        spotifyQuery = [] // 쿼리 초기화
        weatherData.feachWeatherData(lat: locationManager.latitude, lon: locationManager.longitude)
    }

    @Published var spotifyQuery: [String] = [] {
        didSet {
            if spotifyQuery.count >= 2 {
                print(spotifyQuery.count)
                mainViewTitle = spotifyQuery[0] // mainViewTitle 설정 (쿼리 값)
                
                // 2개의 쿼리가 완성 된다면 spotifyAPI를 호출하여 recommendedModelList의 각각 담기
                self.fetchPlayListModel()
            }
        }
    }

    func fetchPlayListModel() {
        
        // 쿼리 수 만큼 반복
        for index in 0..<spotifyQuery.count {
            let manager: HTTPManager<SearchResponse> = HTTPManager<SearchResponse>(apiType: .serchPlaylist(query: spotifyQuery[index]))
            Task { @MainActor in

                let response = await manager.fetchData()
                switch response {
                case .success(let data):
                    let recommendedModelList = data.toRecommendedPlayListModel()
                   
                    // 배열이 해당 인덱스에 값을 가졌는지 확인 (있으면 리스트 바꾸고 없으면 리스트 추가)
                    if index < self.recommendedModelList.count {
                        // 배열의 인덱스에 값을 할당
                        self.recommendedModelList[index] = recommendedModelList
                    } else {
                        // 배열이 해당 인덱스에 값이 없으면 배열에 새로운 요소를 추가
                        self.recommendedModelList.append(recommendedModelList)
                    }

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
                /*
                 뷰 모델에서 사용하는 데이터가 정상적으로 로딩되는지 체크
                 */
                if index == spotifyQuery.count - 1 {
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
    func didUpdateSpotifyRandomQuery(query: String) {
        self.spotifyQuery.append(query)
    }
}
