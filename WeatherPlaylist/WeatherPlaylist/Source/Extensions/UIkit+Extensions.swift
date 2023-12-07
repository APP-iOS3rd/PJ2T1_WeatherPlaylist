//
//  UIkit+Extensions.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/6/23.
//

import Foundation
import UIKit
extension UIImage {
    static var emptyImage: UIImage {
        .init(named: "emptyImg")!
    }
}
extension CGFloat {
    static var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    static var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
}
