//
//  HapticManager.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/12/23.
//

import Foundation
import UIKit
class HapticManager {
    static let shared = HapticManager()
    
    private var generator: UIImpactFeedbackGenerator?
    
    func setupGenerator() {
        generator = UIImpactFeedbackGenerator()
        generator?.prepare()
    }
    
    func createImpact(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        generator?.impactOccurred()
    }
    
    func release() {
        generator = nil
    }
}
