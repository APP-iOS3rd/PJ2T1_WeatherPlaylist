//
//  DrawerExtension.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/6/23.
//


import SwiftUI

public extension View {
    func bottomDrawerView<DrawerContent: View, PullUpView: View>(
        bottomDrawerHeight: CGFloat = 100,
        drawerTopCornersRadius: CGFloat = 32,
        ignoreTopSafeAres: Bool = false,
        @ViewBuilder drawerContent: @escaping () -> DrawerContent,
        @ViewBuilder pullUpView: @escaping (_ shouldGoUp: Bool) -> PullUpView
    ) -> some View {
        self.modifier(EdgesBottomDrawerModifier(
            bottomDrawerHeight: bottomDrawerHeight,
            drawerTopCornersRadius: drawerTopCornersRadius,
            ignoreTopSafeAreas: ignoreTopSafeAres,
            drawerContent: drawerContent,
            pullUpView: pullUpView
        ))
    }
}
