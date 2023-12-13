//
//  BadgeButton.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/12/23.
//

import SwiftUI

struct BadgeButton: View {
    var badge: BadgeModel
    @EnvironmentObject var store: BadgeViewModel
    
    var body: some View {
        Button {
            if let index = store.badgeModelList.firstIndex(of: badge){
                store.badgeModelList[index].isCheck.toggle()
            }
        } label: {
            Text(badge.title)
                .font(.medium16)
                .padding(12)
                .foregroundColor(badge.isCheck ? Color.white : Color.black)
                .background(badge.isCheck ? Color.accentColor : Color.lightBg)
                .frame(width: .infinity)
                .cornerRadius(24)
        }

    }
}
