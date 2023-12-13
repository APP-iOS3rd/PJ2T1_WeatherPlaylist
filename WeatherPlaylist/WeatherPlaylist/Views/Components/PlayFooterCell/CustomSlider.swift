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
    @StateObject var player = PlayerManager.shared
    
    init(value: Binding<Double>, maxValue: Double) {
        self._value = value
        self.maxValue = maxValue
    }
    
    var body: some View {
        GeometryReader{ proxy in
            ZStack(alignment: .topLeading){
                Capsule()
                    .foregroundColor(.secondary)
                    .frame(maxHeight: 3)
                Capsule()
                    .fill(Color("AccentColor"))
                    .frame(width: proxy.size.width * (CGFloat(value) / CGFloat(maxValue)))
                    .contentShape(.capsule)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(maxHeight: 3)
                    .overlay(.white, in: Capsule().stroke(style: .init()))
                Slider(value: $player.songTime,
                       in: 0...30,
                       step: 1,
                       onEditingChanged: { data in
                    if data == true {
                        player.pause()
                        let value = player.songTime
                        player.changeTime(time: value)
                    } else {
                        let value = player.songTime
                        player.changeTime(time: value)
                        player.play()
                    }
                })
                .hidden()
            }
        }
    }
}
