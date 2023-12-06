//
//  BottomDrawer.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/6/23.
//
import SwiftUI

struct EdgesBottomDrawerView<Content: View, DrawerContent: View, PullUpView: View>: View {
    var content: () -> Content
    var drawerContent: () -> DrawerContent
    var pullUpView: (_ shouldGoUp: Bool) -> PullUpView
    var bottomDrawerHeight: CGFloat = 100
    var drawerTopCornersRadius: CGFloat = 32
    var ignoreTopSafeAreas: Bool = false
    
    @State var lastOffset: CGFloat = 0
    @State var offset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0
    
    init(
        bottomDrawerHeight: CGFloat = 100,
        drawerTopCornersRadius: CGFloat = 32,
        ignoreTopSafeAreas: Bool = false,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder drawerContent: @escaping () -> DrawerContent,
        @ViewBuilder pullUpView: @escaping (_ shouldGoUp: Bool) -> PullUpView
    ) {
        self.content = content
        self.drawerContent = drawerContent
        self.pullUpView = pullUpView
        self.drawerTopCornersRadius = drawerTopCornersRadius
        self.bottomDrawerHeight = bottomDrawerHeight
        self.ignoreTopSafeAreas = ignoreTopSafeAreas
    }
    
    var body: some View {
        ZStack {
            content()
                .blur(radius: getBlurRadius())
                .ignoresSafeArea()
            GeometryReader { proxy -> AnyView in
                let height = proxy.frame(in: .global).height
                return AnyView(
                    ZStack {
                        Color.white
                            .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: self.drawerTopCornersRadius))
                        VStack(spacing: 0) {
                            self.pullUpView(-offset > (height - self.bottomDrawerHeight * 2))
                                .frame(height: self.bottomDrawerHeight)
                                .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: self.drawerTopCornersRadius))
                            drawerContent()
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                    }
                    .offset(y: height - self.bottomDrawerHeight)
                    .offset(y: -offset > 0 ? offset : 0)
                    .gesture(
                        DragGesture()
                            .updating(self.$gestureOffset, body: { value, out, _ in
                                out = value.translation.height
                                DispatchQueue.main.async {
                                    self.offset = gestureOffset + lastOffset
                                }
                            })
                            .onEnded({ value in
                                let maxHeight = height - self.bottomDrawerHeight
                                withAnimation {
                                    if -offset > maxHeight / 2 {
                                        offset = -maxHeight
                                    } else {
                                        offset = 0
                                    }
                                }
                                self.lastOffset = offset
                            })
                    )
                )
            }
            .ignoresSafeArea(.all, edges: self.ignoreTopSafeAreas ? [.top, .bottom] : [.bottom])
        }
    }
    
    func getBlurRadius() -> CGFloat {
        let progress = -offset / (UIScreen.main.bounds.height - self.bottomDrawerHeight)
        return progress * 20
    }
}

//#Preview {
//    BottomDrawer()
//}
