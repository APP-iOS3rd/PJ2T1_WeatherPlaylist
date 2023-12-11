//
//  LocationManager.swift
//  SwiftAPIDemo
//
//  Created by 정정욱 on 12/11/23.

import SwiftUI
import CoreLocation

// Core Location 프레임워크를 사용하여 사용자의 위치 정보를 가져오는 역할을 합니다.
class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let locationManager = CLLocationManager() // 위치 관련 이벤트를 받기 위해 필요
    
    // 위치 정보가 업데이트될 때마다 값을 변경하여 관련된 뷰들에게 알립니다
    @Published var latitude: Double = 0.0
    @Published var longitude: Double = 0.0
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization() // 위치 정보 사용 권한을 요청
    }
    
    
   //위치 정보를 업데이트하기 위해 locationManager의 설정을 변경하고, startUpdatingLocation() 메서드를 호출합니다. 이를 통해 실제로 위치 정보를 가져오기 시작합니다.
    func startUpdatingLocation() {
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.startUpdatingLocation()
        }
    }
    // 위치 정보가 업데이트될 때 호출됩니다. 이 메서드에서는 가장 최근의 위치 정보를 가져와서 latitude와 longitude 변수를 업데이트합니다.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
    }
}
