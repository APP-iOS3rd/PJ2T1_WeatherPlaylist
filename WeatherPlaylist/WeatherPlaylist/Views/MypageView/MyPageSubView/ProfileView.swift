//
//  ProfileView.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/6/23.
//

import Foundation
import SwiftUI
struct ProfileView: View {
    @EnvironmentObject var viewModel: ProfileViewModel
    var body: some View {
        HStack{
            Image(uiImage: viewModel.profileModel.image ?? UIImage(systemName: "car")!)
                .resizable()
                .frame(width: 40, height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 0.8)
                        .foregroundStyle(Color.clear)
                )
                .cornerRadius(20)
                .padding(.trailing,13)
            Text(viewModel.profileModel.name)
            Spacer()
            Button(action: {}, label: {
                Text("수정")
            })
        }.padding(.horizontal,25)
    }
}
#Preview {
    ProfileView()
        .environmentObject(ProfileViewModel())
}
