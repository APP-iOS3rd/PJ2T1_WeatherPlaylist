//
//  Font+Extensions.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/6/23.
//

import Foundation
import SwiftUI
extension Font {
    // ExtraBold
    static let extraBold28: Font = .custom(FontType.ExtraBold.rawValue, size: 28)
    // Bold
    static let bold28: Font = .custom(FontType.Bold.rawValue, size: 28)
    static let bold24: Font = .custom(FontType.Bold.rawValue, size: 24)
    static let bold20: Font = .custom(FontType.Bold.rawValue, size: 20)
    static let bold18: Font = .custom(FontType.Bold.rawValue, size: 18)
    static let bold16: Font = .custom(FontType.Bold.rawValue, size: 16)
    static let bold14: Font = .custom(FontType.Bold.rawValue, size: 14)
    
    // SemiBold
    static let semibold16: Font = .custom(FontType.SemiBold.rawValue, size: 16)
    
    // Medium
    static let medium18: Font = .custom(FontType.Medium.rawValue, size: 18)
    static let medium16: Font = .custom(FontType.Medium.rawValue, size: 16)
    
    // Regular
    static let regular12: Font = .custom(FontType.Regular.rawValue, size: 12)
    
    static let regular14: Font = .custom(FontType.Regular.rawValue, size: 14)
    static let regular16: Font = .custom(FontType.Regular.rawValue, size: 16)
    static let regular18: Font = .custom(FontType.Regular.rawValue, size: 18)
    
    // Light
    static let light14: Font = .custom(FontType.Light.rawValue, size: 14)
    static let light10: Font = .custom(FontType.Light.rawValue, size: 10)
    
    // Thin
    static let thin32: Font = .custom(FontType.Thin.rawValue, size: 32)
    //appFont
    static func appFont(for type : FontType, size: CGFloat) -> Font? {
        self.custom(type.rawValue, size: size)
    }
}
enum FontType: String {
    case Black = "Pretendard-Black"
    case ExtraBold = "Pretendard-ExtraBold"
    case Bold = "Pretendard-Bold"
    case SemiBold = "Pretendard-SemiBold"
    case Medium = "Pretendard-Medium"
    case Regular = "Pretendard-Regular"
    case Light = "Pretendard-Light"
    case ExtraLight = "Pretendard-ExtraLight"
    case Thin = "Pretendard-Thin"
}
