//
//  CustomCorners.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/6/23.
//

import SwiftUI

struct CustomCorners: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

//#Preview {
//    CustomCorners()
//}
