//
//  WeatherPlaylistApp.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/5/23.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct WeatherPlaylistApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @ObservedObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            StartView()
                .id(appState.rootViewId)
                .environmentObject(appState)
        }
    }
}
