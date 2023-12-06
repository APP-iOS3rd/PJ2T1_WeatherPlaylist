//
//  BottomDrawerModifier.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/6/23.
//

import SwiftUI

struct EdgesBottomDrawerModifier<DrawerContent: View, PullUpView: View>: ViewModifier {
    var bottomDrawerHeight: CGFloat = 100
    var drawerTopCornersRadius: CGFloat = 32
    var ignoreTopSafeAreas: Bool = false
    var drawerContent: () -> DrawerContent
    var pullUpView: (_ shouldGoUp: Bool) -> PullUpView
    
    func body(content: Content) -> some View {
        EdgesBottomDrawerView(
            bottomDrawerHeight: self.bottomDrawerHeight,
            drawerTopCornersRadius: self.drawerTopCornersRadius,
            ignoreTopSafeAreas: self.ignoreTopSafeAreas,
            content: { content },
            drawerContent: drawerContent,
            pullUpView: pullUpView
        )
    }
}
