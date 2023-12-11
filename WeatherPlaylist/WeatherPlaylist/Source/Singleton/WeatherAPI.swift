//
//  WeatherAPI.swift
//  SwiftAPIDemo
//
//  Created by 정정욱 on 11/30/23.
//

import Foundation

import SwiftUI

struct WeatherResults: Decodable {
    let articles: [WeatherTotalData]
}

// MARK: - Welcome
struct WeatherTotalData: Decodable, Hashable {
    static func == (lhs: WeatherTotalData, rhs: WeatherTotalData) -> Bool {
        return true
    }
    
    func hash(into hasher: inout Hasher) {
        // Combine hash values of all properties using hasher.combine()
    }
    
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let sys: Sys
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
    /*
     main.temp온도. 단위 기본값: 켈빈, 미터법: 섭씨, 영국식: 화씨
     main.feels_like온도. 이 온도 매개변수는 날씨에 대한 인간의 인식을 설명합니다. 단위 기본값: 켈빈, 미터법: 섭씨, 영국식: 화씨
     main.temp_min현재 최저기온
     main.temp_max현재 최고온도
     */
}

// MARK: - Sys
struct Sys: Codable {
    let country: String
    let sunrise, sunset: Int
    /*
     sys.country국가 코드(GB, JP 등)
     sys.sunrise일출 시간, 유닉스, UTC
     sys.sunset일몰 시간, 유닉스, UTC
     */
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
    /*
     weather.id기상 조건 ID
     weather.main날씨 매개변수 그룹(비, 눈, 구름 ​​등)
     weather.description그룹 내 날씨 상태.
     weather.icon날씨 아이콘 ID
     */
}




class WeatherAPI: ObservableObject {
    static let shared = WeatherAPI()
    private init() { }
    @Published var weatherInformation = [WeatherTotalData]()
    
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
        
        //실제 기기에서 돌릴때는 아래 url 사용
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
            
//            let str = String(decoding: data, as: UTF8.self)
//            print(str)
            do {
                let json = try JSONDecoder().decode(WeatherTotalData.self, from: data)

                DispatchQueue.main.async {
                    self.weatherInformation = [json] // Wrap 'json' in an array
                    
                    // 파싱이 끝나면 user의 날씨 데이터만 가져오는 로직을 실행
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
