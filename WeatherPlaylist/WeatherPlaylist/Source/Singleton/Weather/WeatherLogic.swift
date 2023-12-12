//
//  WeatherLogic.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/6/23.
//

import Foundation
import Combine

public enum WeatherType {
    case sunny
    case cloudy
    case rainy
    case snowy
    case thunderstorm
}

//MARK: - 날씨 체크를 하고 있는지에 대한 싱글톤 패턴 클래스
public class WeatherLogic: ObservableObject {
    static var shared: WeatherLogic = .init()
    @Published var isChecking: Bool = UserDefaults.standard.bool(forKey: "weatherChecking") {
        didSet {
            UserDefaults.standard.setValue(self.isChecking, forKey: "weatherChecking")
            print(self.isChecking ? "체크중" : "체크해제")
        }
    }
    
    // 임시 사용자 현제 날씨
    @Published var userWeather: WeatherType = .rainy {
        didSet {
            updateMainTitle()
        }
    }

    @Published var mainTitle: String = "화창한 날엔 이 노래 어때요?"

    private func updateMainTitle() {
        switch userWeather {
        case .sunny:
            mainTitle = "화창한 날엔 이 노래 어때요?"
        case .cloudy:
            mainTitle = "흐린 날엔 이 노래 어때요?"
        case .rainy:
            mainTitle = "비오는 날엔 이 노래 어때요?"
        case .snowy:
            mainTitle = "눈오는 날엔 이 노래 어때요?"
        case .thunderstorm:
            mainTitle = "천둥 번개 치는 날엔 이 노래 어때요?"
        }
    }
}
