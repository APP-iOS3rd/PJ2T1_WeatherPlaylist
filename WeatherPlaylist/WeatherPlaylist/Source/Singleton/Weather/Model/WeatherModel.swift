//
//  WeatherModel.swift
//  WeatherPlaylist
//
//  Created by 정정욱 on 12/11/23.
//

import Foundation


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


// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
    // 사용자 위치(위도, 경도)
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

