//
//  WebViewModel.swift
//  SpotifyAuthDemo
//
//  Created by 김성엽 on 12/7/23.
//

import Foundation
import Combine

class WebViewModel: ObservableObject {
    var foo = PassthroughSubject<Bool, Never>()
    var bar = PassthroughSubject<Bool, Never>()
}
