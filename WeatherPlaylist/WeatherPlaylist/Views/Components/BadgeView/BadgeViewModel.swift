//
//  BadgeViewModel.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/12/23.
//

import Foundation
import Combine

final class BadgeViewModel: ObservableObject {
    @Published var badgeModelList: [BadgeModel] = []
        
    init() {
        fetchModel()
    }
  
    public func fetchModel() {
        self.badgeModelList = [
            BadgeModel(title: "에너지 충전", isCheck: false),
            BadgeModel(title: "운동", isCheck: false),
            BadgeModel(title: "집중", isCheck: true),
            BadgeModel(title: "힙스터", isCheck: false),
            BadgeModel(title: "휴식", isCheck: false),
            BadgeModel(title: "공부", isCheck: true),
            BadgeModel(title: "주말", isCheck: false),
            BadgeModel(title: "하이틴", isCheck: false),
            BadgeModel(title: "인기TOP", isCheck: true),
            BadgeModel(title: "OST", isCheck: false),
            BadgeModel(title: "노래방", isCheck: false)
        ]
        
    }
}
