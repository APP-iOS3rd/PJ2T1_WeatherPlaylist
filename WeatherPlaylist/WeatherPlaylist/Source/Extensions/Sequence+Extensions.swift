//
//  Sequence+Extensions.swift
//  WeatherPlaylist
//
//  Created by 이명섭 on 12/13/23.
//

import Foundation

extension Sequence {
    func asyncForeach(_ operation: (Element) async throws -> Void) async rethrows {
        for element in self {
            try await operation(element)
        }
    }
}
