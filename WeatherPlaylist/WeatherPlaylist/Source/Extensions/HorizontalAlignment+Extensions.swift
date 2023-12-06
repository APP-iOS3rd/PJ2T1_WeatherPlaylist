//
//  HorizontalAlignment.swift
//  WeatherPlaylist
//
//  Created by seobe22 on 12/6/23.
//

import Foundation
import SwiftUI

extension HorizontalAlignment {
    enum playlistCoverImageHorizon: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[HorizontalAlignment.center]
        }
        static let playlistCoverImageAlignment = HorizontalAlignment(playlistCoverImageHorizon.self)
    }
}
