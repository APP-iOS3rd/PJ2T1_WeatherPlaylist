//
//  NavigationHeaderView.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/14/23.
//

import SwiftUI

struct NavigationHeaderView: View {
    @Environment(\.dismiss) private var dismiss
    var viewModel: PlaylistViewModel
    var showDescr: Bool

    var body: some View {
        Group {
            if showDescr {
                VStack(spacing: 0){
                    Spacer().frame(height: 50)

                    HStack{
                        Button{
                            dismiss()
                        } label :{
                            Image(systemName: "chevron.backward")
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()

                    PlaylistCoverImageView(coverImageUrl: viewModel.playlistInfo.image ?? "")
                       .frame(maxWidth: .infinity)
                    PlaylistHeader()
                        .environmentObject(viewModel)

                }
                .padding()
                .frame(maxWidth:.infinity,maxHeight: .infinity)
                .background(Color.lightBg)
                .overlay(BottomBorder().stroke(Color.gray.opacity(0.1), lineWidth:1))


            } else {
                ZStack {
                    VStack {
                        Spacer().frame(height: 50)

                        HStack {
                            Button{
                                dismiss()
                            } label: {
                                Image(systemName: "chevron.backward")
                            }
                            Spacer()
                        }
                        .padding(.bottom,8)

                        HStack{
                            PlaylistCoverImageSmallView(coverImageUrl: viewModel.playlistInfo.image ?? "")
                            Text(viewModel.playlistInfo.mainTitle)
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment:.leading)
                        }
                     }
                    .padding()
                    .background(Color.lightBg)
                    .overlay(BottomBorder().stroke(Color.gray.opacity(0.4), lineWidth:1))

                    HStack{
                        Spacer()
                        Button {
                           viewModel.pushPlayButton()
                        } label: {
                           Image(systemName:  "play.fill")
                               .foregroundStyle(.white)
                               .font(.system(size: 24))

                        }
                        .padding()
                        .background(Color.accentColor)
                        .cornerRadius(48)
                    }
                    .padding()
                    .offset(y:80)
                }
            }
        }
    }
}
