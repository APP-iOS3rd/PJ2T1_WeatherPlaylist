//
//  PlayMusicView.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/6/23.
//

import SwiftUI

struct PlayMusicView: View {
//    @State var temp: MusicModel
    @State var temp: PlaylistTrackModel
    
    @State private var isShowingPlayer = false
    @StateObject var viewModel: PlayMusicViewModel  = .init()
    
    var body: some View {
        NavigationStack {
            HeaderView(title: viewModel.playMusicModel.playlistTitle)
            ZStack{
                VStack{
                    musicImageView
                    musicSlider
                    musicController
                    Spacer()
                        .scaleEffect(0)
                }
                .padding(.horizontal)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(Color.white.edgesIgnoringSafeArea(.bottom))
            .bottomDrawerView(
                bottomDrawerHeight: 80,
                drawerTopCornersRadius: 16,
                ignoreTopSafeAres: false) {
                    bottomDrawer
                } pullUpView: { shouldGoUp in
                    // Drawer pull up 시
                    ZStack {
                        Color.gray.opacity(0.9)
                        if shouldGoUp {
                            Image(systemName: "chevron.down")
                                .foregroundColor(Color.white)
                        } else {
                            Image(systemName: "chevron.up")
                                .foregroundColor(Color.white)
                        }
                    }
                }
        }
    }
     
    func moveTrack(from source: IndexSet, to destination: Int) {
        viewModel.playlistModelList.move(fromOffsets: source, toOffset: destination)
    }

    func deleteTrack(at offsets: IndexSet) {
        viewModel.playlistModelList.remove(atOffsets: offsets)
    }
}

//#Preview {
//    PlayMusicView()
//}

extension PlayMusicView {
    
    private var musicImageView: some View{
        VStack{
            // Image 로드시,
            CachedImage(url: nil){ phase in
                switch phase {
                case .success(let image) :
                    image.resizable()
                case .empty, .failure(_) :
                    ProgressView()
                }
            }
            .scaledToFill()
            .frame(maxWidth:340, maxHeight: 340)
            .clipShape(Rectangle())
            .cornerRadius(10)
            .scaleEffect(1)
                //.padding(.horizontal,15)
                
            HStack{
                VStack{
                    Text(viewModel.playMusicModel.songName)
                        .font(.bold28)
                        .frame(maxWidth: .infinity,alignment: .leading)
                    Text(viewModel.playMusicModel.artist)
                        .font(.regular18)
                        .frame(maxWidth: .infinity,alignment: .leading)
                }
                Image(systemName: "heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width:20,height: 20)
                    //MARK: - 살짝 커졌다 작아지는 애니메이션?
                    .scaleEffect(1)
                
            }.padding(.vertical,24)
            .padding(.horizontal)
            
        }
        //.padding()
        
    }
    
    private var musicSlider: some View{
        VStack{
            HStack{
                Text("0:00")
                    .font(.medium16)
                Spacer()
                Text("3:00")
                    .font(.medium16)
            }
            .font(.system(size: 16))
            .fontWeight(.medium)
            .foregroundColor(.gray)
            .padding(.horizontal)
            
            HStack{
                Rectangle()
                    .frame(width: .screenWidth - 40, height: 4)
                    .foregroundColor(Color.gray)
                    .opacity(0.3)
                    .overlay(
                        HStack {
                            //프로그래스바?
                            Rectangle()
                                .frame(width: 100, height: 4)
                            Spacer()
                        }
                    )
            }
            .padding(.horizontal)
        }
        .padding(.top, 14)
        .padding(.horizontal, 0)
        
    }
    
    private var musicController:some View{
        VStack{
          
            HStack{
                Image(systemName: "shuffle")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 22)
                    .onTapGesture {}
                Spacer()
                Image(systemName: "backward.end.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 24)
                    .onTapGesture {}
                Spacer()
                Image(systemName: "play.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 32)
                    .onTapGesture {}
                     
                Spacer()
                Image(systemName: "forward.end.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 24)
                    .onTapGesture {}
                Spacer()
                Image(systemName: "repeat")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 22)
                    .onTapGesture {}
                
            }.padding()
        }
    }
    
    private var bottomDrawer:some View{
        ZStack {
            Color.gray.opacity(0.9)
            NavigationView {
                VStack{
                    List {
                        ForEach(viewModel.playlistModelList.indices, id: \.self) { index in
                            HStack{
                                
                                let playlistModel = viewModel.playlistModelList[index]
                                
                                AsyncImage(url: URL(string: playlistModel.coverImage)){ image in
                                   image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 50, height: 50)
                                .cornerRadius(4)

                                    
                                VStack(alignment: .leading){
                                    Text(playlistModel.songName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text(playlistModel.artist)
                                        .font(.body)
                                        .foregroundStyle(.white)
                                }
                            }
                            .listRowBackground(Color.gray.opacity(0.7))
                        } 
                        .onMove(perform: moveTrack)
                        .onDelete(perform: deleteTrack)
                    }
                    .scrollContentBackground(.hidden)
                    
                }
                 
                .background(Color.gray.opacity(0.9))
                .toolbar {
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                        EditButton()
                    }
                }
            }
            
            
        }
    }
    
}
