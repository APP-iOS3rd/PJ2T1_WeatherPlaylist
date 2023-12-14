//
//  WeatherPlaylistApp.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/5/23.
//

import SwiftUI

@main
struct WeatherPlaylistApp: App {
    @ObservedObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            StartView()
                .id(appState.rootViewId)
                .environmentObject(appState)
        }
    }
}
