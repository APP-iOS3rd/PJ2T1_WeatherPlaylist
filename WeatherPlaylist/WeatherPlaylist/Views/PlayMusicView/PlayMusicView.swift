//
//  PlayMusicView.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/6/23.
//

import SwiftUI

struct PlayMusicView: View {
    // MARK: PlaylistModel을 TrackModel로 변경하였지만, 기존의 PlaylistTrackModel을 사용하는 부분이 존재하여 주석처리하였습니다.
    @State var temp: PlaylistTrackModel
//    @State var temp: PlaylistModel
    var body: some View {
        NavigationStack {
            HeaderView(title: "에너지 충전 슈퍼믹스")
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
     
//    func moveArtist(from source: IndexSet, to destination: Int) {
//          .move(fromOffsets: source, toOffset: destination)
//    }
//     
//    func deleteArtist(at offsets: IndexSet) {
//         .remove(atOffsets: offsets)
//    }
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
                    Text("title")
                        .font(.bold28)
                        .frame(maxWidth: .infinity,alignment: .leading)
                    Text("artist")
                        .font(.regular18)                        .frame(maxWidth: .infinity,alignment: .leading)
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
                        // 현재 dummy Data
                        ForEach(0..<3, id: \.self) { i in
                            HStack{
//                                        AsyncImage(url: URL(string: )){ image in
//                                            image.resizable()
//                                        }placeholder: {
//                                            ProgressView()
//                                        }
                                Rectangle()
                                .frame(width: 50, height: 50)
                                .cornerRadius(4)

                                    
                                VStack(alignment: .leading){
                                    Text("hihi")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text("hihih")
                                        .font(.body)
                                        .foregroundStyle(.white)
                                }
                            }
                            .listRowBackground(Color.gray.opacity(0.7))
                        }
                        // list 삭제 이동기능 추가시 사용
//                                .onMove(perform: moveArtist)
//                                .onDelete(perform: deleteArtist)
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
