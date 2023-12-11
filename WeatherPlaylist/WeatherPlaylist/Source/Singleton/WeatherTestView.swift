//
//  WeatherTestView.swift
//  WeatherPlaylist
//
//  Created by 정정욱 on 12/11/23.
//
import SwiftUI


struct WeatherTestView: View {

    @StateObject var network = WeatherAPI.shared

    var body: some View {
        NavigationStack {
            List{
                ForEach(network.weatherInformation, id: \.self) { result in
                    Text("서울").foregroundStyle(Color.white)
                    Text("위도:\(result.coord.lat) 경도:\(result.coord.lon)").foregroundStyle(Color.black)
                   
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
            network.feachWeatherData(lat: locationManager.latitude, lon: locationManager.longitude)
        }
    }
   
}



#Preview {
    WeatherTestView()
}
