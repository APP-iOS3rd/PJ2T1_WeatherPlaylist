//
//  NavigationHeaderView.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/14/23.
//

import SwiftUI

struct NavigationHeaderView: View {
   // @Environment(\.dismiss) var dismiss
    var viewModel: PlaylistViewModel
    var showDescr: Bool
    var onDismiss: () -> Void
    var body: some View {
        Group {
            if showDescr {
                VStack(spacing: 0){
                    Spacer().frame(height: 50)

                    HStack{
                        Button{
                            onDismiss()
                            
                        } label :{
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .scaledToFit()
                                .frame(width:20,height: 20)
                                .scaleEffect(1)
                            Spacer()
                        }
                    }
                    .padding(.horizontal,8)

                    PlaylistCoverImageView(coverImageUrl: viewModel.playlistInfo.image ?? "")
                       .frame(maxWidth: .infinity)
                       .padding(.bottom,12)
                    PlaylistHeader()
                        .environmentObject(viewModel)

                }
                .padding()
                .frame(maxWidth:.infinity,maxHeight: .infinity)
                .background(Color.lightBg)
                .overlay(BottomBorder().stroke(Color.gray.opacity(0.1), lineWidth:1))
                .ignoresSafeArea()



            } else {
                ZStack {
                    VStack {
                        Spacer().frame(height: 50)

                        HStack {
                            Button{
                                onDismiss()
                            } label: {
                                Image(systemName: "chevron.backward")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:20,height: 20)
                                    .scaleEffect(1)
                            }
                            
                            HStack{
                                PlaylistCoverImageSmallView(coverImageUrl: viewModel.playlistInfo.image ?? "")
                                Text(viewModel.playlistInfo.mainTitle)
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment:.leading)
                            }
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
                            Image(systemName:  PlayerManager.shared.isPlaying ? "pause.fill" : "play.fill")
                               .foregroundStyle(.white)
                               .font(.system(size: 24))

                        }
                        .padding()
                        .background(Color.accentColor)
                        .cornerRadius(48)
                    }
                    .padding()
                    .offset(y:60)
                }
                .ignoresSafeArea()

            }
        }
    }
}
