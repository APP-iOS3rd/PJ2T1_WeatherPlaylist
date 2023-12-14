//
//  MusicIcon.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/14/23.
//

import SwiftUI

struct MusicIcon: View {
    @State private var drawingHeight = true
    var frameWidth: CGFloat = 30
    var frameHeight: CGFloat = 30
    var barWidth: CGFloat = 3
    
    var animation: Animation {
        return .linear(duration: 0.5).repeatForever()
    }
 
    var body: some View {
        HStack(spacing: 2) {
            bar(low: 0.4, high: 1.0, width: barWidth)
                .animation(animation.speed(1.5), value: drawingHeight)
            bar(low: 0.3,high: 1.0, width: barWidth)
                .animation(animation.speed(1.2), value: drawingHeight)
            bar(low: 0.5,high: 1.0, width: barWidth)
                .animation(animation.speed(1.0), value: drawingHeight)
            bar(low: 0.3,high: 1.0, width: barWidth)
                .animation(animation.speed(1.7), value: drawingHeight)
            bar(low: 0.5,high: 1.0, width: barWidth)
                .animation(animation.speed(1.0), value: drawingHeight)
        }
        .frame(width: frameWidth, height: frameHeight)
        .clipShape(Rectangle())
        .clipped()
        .onAppear{
            drawingHeight.toggle()
        }
    }
 
    func bar(low: CGFloat = 0.0, high: CGFloat = 1.0, width: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: 0)
            .fill(.mint.gradient)
            .frame(width: barWidth, height: min( (drawingHeight ? high : low) * frameHeight, frameHeight), alignment: .bottom)
             
    }
}

#Preview {
    MusicIcon()
}
