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
            CachedImage(url: viewModel.profileModel.image) {phase in
                ProfileImage(phase: phase)
            }
            Text(viewModel.profileModel.name)
                .font(.bold16)
            Spacer()
        }.padding(.horizontal,25)
    }
}
#Preview {
    ProfileView()
        .environmentObject(ProfileViewModel())
}

struct ProfileImage: View {
    @State var phase: AsyncImagePhase
    var body: some View {
        switch phase {
        case .empty, .failure(_):
            Image(uiImage: .emptyImage)
                .resizable()
                .frame(width: 40, height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 0.8)
                        .foregroundStyle(Color.clear)
                )
                .cornerRadius(20)
                .padding(.trailing,13)
        case .success(let image):
            image
                .resizable()
                .frame(width: 40, height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 0.8)
                        .foregroundStyle(Color.clear)
                )
                .cornerRadius(20)
                .padding(.trailing,13)
        @unknown default:
            Image(uiImage: .emptyImage)
                .resizable()
                .frame(width: 40, height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 0.8)
                        .foregroundStyle(Color.clear)
                )
                .cornerRadius(20)
                .padding(.trailing,13)
        }
    }
}
