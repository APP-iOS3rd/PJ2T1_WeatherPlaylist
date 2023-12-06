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
            AsyncImage(url: viewModel.profileModel.image) {phase in
                switch phase {
                case .success(let image) :
                    ProfileImage(image: image)
                case .empty, .failure(_):
                    ProfileImage()
                @unknown default:
                    ProfileImage()
                }
            }
            Text(viewModel.profileModel.name)
                .font(.system(size: 18))
            Spacer()
        }.padding(.horizontal,25)
    }
}
#Preview {
    ProfileView()
        .environmentObject(ProfileViewModel())
}

struct ProfileImage: View {
    @State var image: Image?
    var body: some View {
        if let image = image {
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
        } else {
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
