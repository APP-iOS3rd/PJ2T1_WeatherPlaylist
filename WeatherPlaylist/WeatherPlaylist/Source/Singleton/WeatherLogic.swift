//
//  WeatherLogic.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/6/23.
//

import Foundation
import Combine
//MARK: - 날씨 체크를 하고 있는지에 대한 싱글톤 패턴 클래스
public class WeatherLogic: ObservableObject {
    static var shared: WeatherLogic = .init()
    @Published var isChecking: Bool = false {
        didSet {
            print(self.isChecking ? "체크중" : "체크해제")
        }
    }
    
}
