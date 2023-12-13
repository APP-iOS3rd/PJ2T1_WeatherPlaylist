//
//  WeatherAPI.swift
//  SwiftAPIDemo
//
//  Created by 정정욱 on 11/30/23.
//

import Foundation

import SwiftUI


protocol WeatherAPIDelegate: AnyObject {
    func didUpdateSpotifyRandomQuery(query: String)
}

class WeatherAPI: ObservableObject {
    static let shared = WeatherAPI()
    private init() { }
    
  
    @Published var weatherInformation = [WeatherTotalData]()
    
    // ⭐️ 최종 사용자 위치 기준 날씨 상태를 표현해 주는 변수
    @Published var userWatherStatus: String = "맑은 아침"
    // ⭐️ 최종 사용자 4계절 파악 변수
    @Published var userSeason: String = "여름"
    
    
    weak var delegate: WeatherAPIDelegate?
    
    
    private var apiKey: String? {
        get {
            let keyfilename = "ApiKeys"
            let api_key = "WeatherAPI_KEY"
            
            // 생성한 .plist 파일 경로 불러오기
            guard let filePath = Bundle.main.path(forResource: keyfilename, ofType: "plist") else {
                fatalError("Couldn't find file '\(keyfilename).plist'")
            }
            
            // .plist 파일 내용을 딕셔너리로 받아오기
            let plist = NSDictionary(contentsOfFile: filePath)
            
            // 딕셔너리에서 키 찾기
            guard let value = plist?.object(forKey: api_key) as? String else {
                fatalError("Couldn't find key '\(api_key)'")
            }
            
            return value
        }
    }
    
    func feachWeatherData(lat: Double, lon: Double) {
        //print(apiKey)
        guard let apiKey = apiKey else { return }
        
        //⚠️ 실제 기기에서 돌릴 때는 아래 URL 사용
        //let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)"
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(37.5125)&lon=\(127.102778)&appid=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        print(url)
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                // 정상적으로 값이 오지 않았을 때 처리
                print("정상적인 값 오지 않음")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let json = try JSONDecoder().decode(WeatherTotalData.self, from: data)

                DispatchQueue.main.async {
                    self.weatherInformation = [json]
                    
                    // ⭐️ 파싱이 끝나면 user의 날씨 데이터만 가져오는 SettingLogic을 실행
                    self.fetchUserWeatherData()
                }
            }  catch let error {
                print(error.localizedDescription)
            }
            
        }
        task.resume()
    }
    
    func fetchUserWeatherData() {
        // 기존 값을 초기화
        self.userWatherStatus = ""
        self.userSeason = ""
        
        // 해당 부분에서 파싱된 값 중 싱글 톤 패턴으로 필요한 사용자의 날씨 데이터 가져오는 로직을 처리
        
        // 날씨 상태
        self.userWatherStatus = self.getWeatherStatus(icon: self.weatherInformation[0].weather[0].icon)
        
        // 계절
        let currentDate = Date()
        let calendar = Calendar.current
        self.userSeason = getSeasonStatus(season: String(calendar.component(.month, from: currentDate)))
        
        // 스포티파이 키워드
        var keyword1 = self.getSpotifyKeyWords(icon: self.weatherInformation[0].weather[0].icon)
        var keyword2 = self.getSpotifyKeyWords(icon: self.weatherInformation[0].weather[0].icon)
        
        // 스포티파이 쿼리 질의문 = 계절 + 키워드 + 날씨 상태 ex 겨울 적적하게 눈오는 밤
        let spotifyQuery1 = "\(userSeason) \(keyword1) \(userWatherStatus)"
        let spotifyQuery2 = "\(userSeason) \(keyword2) \(userWatherStatus)"
        
        // ⭐️ 최종 스포티파이 질의문 전달 
        print(spotifyQuery1)
        print(spotifyQuery2)
        delegate?.didUpdateSpotifyRandomQuery(query: spotifyQuery1)
        delegate?.didUpdateSpotifyRandomQuery(query: spotifyQuery2)

    
    }


    
    func getSeasonStatus(season: String) -> String {
        switch season {
        case "12", "1", "2":
            return "겨울"
        case "3", "4", "5":
            return "봄"
        case "6", "7", "8":
            return "여름"
        default:
            return "가을"
        }
    }
    
    func getWeatherStatus(icon: String) -> String {
        switch icon {
        case "01d", "02d":
            return "맑은 아침"
        case "01n", "02n":
            return "맑은 밤"
        case "03d", "04d":
            return "흐린 아침"
        case "03n", "04n":
            return "흐린 밤"
        case "09d", "10d", "11d":
            return "비오는 아침"
        case "09n", "10n", "11n":
            return "비오는 밤"
        case "13d":
            return "눈오는 아침"
        case "13n":
            return "눈오는 밤"
        case "50d":
            return "안개낀 아침"
        case "50n":
            return "안개낀 밤"
        default:
            return "알 수 없는 날씨"
        }
    }
    
    func getSpotifyKeyWords(icon: String) -> String {
        switch icon {
        case "01d", "02d":
            let keywords = ["화창한", "상쾌한", "산뜻한", "따뜻한", "썸녀랑 데이트 하고 싶은", "도입부부터 기분 좋아지는", "햇살 좋은 날"]
            let randomIndex = Int.random(in: 0..<keywords.count)
            return keywords[randomIndex]
        case "01n", "02n":
            let keywords = ["공기좋은", "선선한", "달이 잘보이는", "별이 쏟아지는", "썸녀랑 데이트 하고 싶은"]
            let randomIndex = Int.random(in: 0..<keywords.count)
            return keywords[randomIndex]
        case "03d", "04d":
            let keywords = ["집에서 쉬고싶은", "누워서 아무것도 하기 싫은", "넷플릭스 보고싶은"]
            let randomIndex = Int.random(in: 0..<keywords.count)
            return keywords[randomIndex]
        case "03n", "04n":
            let keywords = ["먹먹하게", "어둡게", "꾸리꾸리하게", "세상이 멸망할거 같이", "넷플릭스 보기 좋은"]
            let randomIndex = Int.random(in: 0..<keywords.count)
            return keywords[randomIndex]
        
        case "09d", "10d", "11d":
            let keywords = ["촉촉한", "세상이 멸망할거 같이, 비 냄새나는", "영화 속 주인공이 된 듯한", "잔잔하게", "무섭게"]
            let randomIndex = Int.random(in: 0..<keywords.count)
            return keywords[randomIndex]
        case "09n", "10n", "11n":
            let keywords = ["추적추적", "소나기, 감성 터지는", "울고싶게", "잔잔하게", "우울하게"]
            let randomIndex = Int.random(in: 0..<keywords.count)
            return keywords[randomIndex]
        case "13d":
            let keywords = ["새하얀", "눈에띠네, 함박", "울고싶게", "펑펑 내리는", "첫"]
            let randomIndex = Int.random(in: 0..<keywords.count)
            return keywords[randomIndex]
        case "13n":
            let keywords = ["산타가 보고싶은", "케롤이 듣고 싶은, 첫 사랑이 생각나는", "벅차오르는", "펑펑 내리는", "첫"]
            let randomIndex = Int.random(in: 0..<keywords.count)
            return keywords[randomIndex]
        case "50d":
            let keywords = ["센치한", "우울한, 짙은", "적적하게", "영화같은", "슬픈"]
            let randomIndex = Int.random(in: 0..<keywords.count)
            return keywords[randomIndex]
        case "50n":
            let keywords = ["센치한", "우울한, 짙은", "적적하게", "영화같은", "슬픈"]
            let randomIndex = Int.random(in: 0..<keywords.count)
            return keywords[randomIndex]
        default:
            return "알 수 없는 날씨"
        }
    }
}
