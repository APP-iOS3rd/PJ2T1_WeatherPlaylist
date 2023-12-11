//
//  WeatherAPI.swift
//  SwiftAPIDemo
//
//  Created by 정정욱 on 11/30/23.
//

import Foundation

import SwiftUI



class WeatherAPI: ObservableObject {
    static let shared = WeatherAPI()
    private init() { }
    @Published var weatherInformation = [WeatherTotalData]()
    
    // ⭐️ 최종 사용자 위치 기준 날씨 상태를 표현해 주는 변수
    @Published var userWatherStatus: String = "맑은 아침"
    
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
                    self.feachUserWeatherData()
                }
            }  catch let error {
                print(error.localizedDescription)
            }
            
        }
        task.resume()
    }
    
    func feachUserWeatherData(){
        // 해당 부분에서 파싱된 값 중 싱글 톤 패턴으로 필요한 사용자의 날씨 데이터 가져오는 로직을 처리
        self.userWatherStatus = self.getWeatherStatus(icon: self.weatherInformation[0].weather[0].icon)
        // self.userWatherStatus을 이용하여 스포티파이 API 전달 값으로 사용가능
    }
    
    func getWeatherStatus(icon: String) -> String {
        switch icon {
        case "01d":
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

}
