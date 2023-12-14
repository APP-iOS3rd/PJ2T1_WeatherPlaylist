//
//  SigningManager.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/12/23.
//

import Foundation
import Combine
final class SigningManager: ObservableObject {
    static let shared: SigningManager = .init()
    @Published var isLogout: Bool = false
}
