//
//  ToggleView.swift
//  IpodSwiftUI
//
//  Created by 정정욱 on 12/5/23.
//


import SwiftUI

struct ToggleView: View {
    @State var isLightMode: Bool = false
    
    var body: some View {
        ZStack {
            background
            
            Toggle("", isOn: $isLightMode.animation(.easeInOut))
                .frame(width: 200, height: 50, alignment: .center)
                .toggleStyle(MyToggleStyle())
        }
        .preferredColorScheme(isLightMode ? .light : .dark)
    }
    
    @ViewBuilder private var background: some View {
        if isLightMode {
            Color("lightBg")
                .ignoresSafeArea()
        } else {
            Color("darkBg")
                .ignoresSafeArea()
        }
    }
}

struct ToggleView_Previews: PreviewProvider {
    static var previews: some View {
        ToggleView()
    }
}
