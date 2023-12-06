//
//  Font+Extensions.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/6/23.
//

import Foundation
import SwiftUI
extension Font {
    //appFont
    /**
     앱 폰트는 기본적으로 스태틱 상수로 전부 도입해두었습니다.
     하지만 직접 타입과 폰트를 주어야 할 수도 있어서 appFont라는 스태틱 함수를 만들었습니다.
     - parameters:
        - type: FontType = [.Black, .ExtraBold, .Bold, .SemiBold, .Medium, .Regular, .Light, .ExtraLight, .Thin]
        - size: CGFloat
     */
    static func appFont(for type : FontType, size: CGFloat) -> Font? {
        self.custom(type.rawValue, size: size)
    }
    // ExtraBold
    // Bold
    static let bold30: Font = .custom(FontType.Bold.rawValue, size: 30)
    static let bold22: Font = .custom(FontType.Bold.rawValue, size: 22)
    static let bold20: Font = .custom(FontType.Bold.rawValue, size: 20)
    static let bold18: Font = .custom(FontType.Bold.rawValue, size: 18)
    static let bold16: Font = .custom(FontType.Bold.rawValue, size: 16)
    static let bold14: Font = .custom(FontType.Bold.rawValue, size: 14)
    
    // SemiBold
    static let semibold18: Font = .custom(FontType.SemiBold.rawValue, size: 18)

    // Medium
    static let medium16: Font = .custom(FontType.Medium.rawValue, size: 16)
    static let medium14: Font = .custom(FontType.Medium.rawValue, size: 14)

    // Regular
    static let regular12: Font = .custom(FontType.Regular.rawValue, size: 12)
    static let regular14: Font = .custom(FontType.Regular.rawValue, size: 14)
    static let regular16: Font = .custom(FontType.Regular.rawValue, size: 16)
    static let regular18: Font = .custom(FontType.Regular.rawValue, size: 18)
    
    //Light
    static let light14: Font = .custom(FontType.Light.rawValue, size: 14)
    static let light10: Font = .custom(FontType.Light.rawValue, size: 10)

    //Thin
    static let thin32: Font = .custom(FontType.Thin.rawValue, size: 32)

    
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
