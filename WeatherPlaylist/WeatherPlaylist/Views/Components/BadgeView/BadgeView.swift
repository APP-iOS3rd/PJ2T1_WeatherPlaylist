//
//  BadgeView.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/12/23.
//

import SwiftUI

struct BadgeView: View {
    
    @StateObject var viewModel: BadgeViewModel = .init()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(viewModel.badgeModelList) { index in
                    BadgeButton(badge: index)
                        .environmentObject(viewModel)
                }
            }
            .frame(minWidth:0, maxWidth: .infinity)
            
        }
    }
    
}

#Preview {
    BadgeView()
}
