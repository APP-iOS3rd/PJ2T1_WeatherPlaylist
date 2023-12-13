//
//  WeatherTestView.swift
//  WeatherPlaylist
//
//  Created by 정정욱 on 12/11/23.
//
import SwiftUI


// MARK: - 날씨 관련 API TestView
struct WeatherTestView: View {

    @StateObject var weatherData = WeatherAPI.shared
    let currentDate = Date()
    

    var body: some View {
        NavigationStack {
            List{
                ForEach(weatherData.weatherInformation, id: \.self) { result in
                    // 사용자 위도, 경도
                    Text("위도:\(result.coord.lat) 경도:\(result.coord.lon)").foregroundStyle(Color.black)
                    Text(result.weather[0].icon)
                    
                    // 사용자 위치 날씨 상태
                    Text(weatherData.userWatherStatus)
                    
                    // 사용자 날짜
                    Text(weatherData.userSeason)
                    
                    // 스포티파이 쿼리문 
                    Text(weatherData.spotifyRandomQuery)
                    
                    // 사용자 위치 날씨 아이콘
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(result.weather[0].icon)@2x.png")) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 30, height: 30) // 회고
                    
                }
            }
        }
        .onAppear {
           // 시뮬 환경에서 값을 가져오지 못함 임시로 일단 넣어서 테스트
            let locationManager = LocationManager()
            locationManager.startUpdatingLocation()
            print("위도: \(locationManager.latitude), 경도: \(locationManager.longitude)")
          
            // 사용자 위도, 경도를 전달하여 API 호출
            weatherData.feachWeatherData(lat: locationManager.latitude, lon: locationManager.longitude)
        }
    }
   
}



#Preview {
    WeatherTestView()
}
