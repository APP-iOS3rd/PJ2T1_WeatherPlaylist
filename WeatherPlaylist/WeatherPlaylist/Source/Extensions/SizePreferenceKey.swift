//
//  SizePreferenceKey.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/14/23.
//

import SwiftUI

struct SizePreferenceKey: PreferenceKey{
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
