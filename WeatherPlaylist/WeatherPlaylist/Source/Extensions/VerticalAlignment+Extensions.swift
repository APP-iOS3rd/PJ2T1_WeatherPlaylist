//
//  VerticalAlignment+Extensions.swift
//  WeatherPlaylist
//
//  Created by seobe22 on 12/6/23.
//

import Foundation
import SwiftUI

extension VerticalAlignment {
    enum playlistCoverImageVertical: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[VerticalAlignment.center]
        }
        static let playlistCoverImageAlignment = VerticalAlignment(playlistCoverImageVertical.self)
    }
}
