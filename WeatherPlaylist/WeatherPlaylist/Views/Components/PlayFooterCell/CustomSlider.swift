//
//  CustomSlider.swift
//  WeatherPlaylist
//
//  Created by 김성엽 on 12/13/23.
//

import SwiftUI

struct CustomSlider: View {
    @Binding var value: Double
    private var maxValue: Double
    
    init(value: Binding<Double>, maxValue: Double) {
        self._value = value
        self.maxValue = maxValue
    }
    var body: some View {
        GeometryReader{ proxy in
            ZStack(alignment: .center){
                Capsule()
                    .foregroundColor(.secondary)
                
                Capsule()
                    .fill(Color("AccentColor"))
                    .frame(width: proxy.size.width * (CGFloat(value) / CGFloat(maxValue)))
                    .contentShape(.capsule)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .overlay(.white, in: Capsule().stroke(style: .init()))
            }
        }
    }
}


