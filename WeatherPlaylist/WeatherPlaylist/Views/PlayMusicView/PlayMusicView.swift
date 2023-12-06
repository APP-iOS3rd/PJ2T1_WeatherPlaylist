//
//  PlayMusicView.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/6/23.
//

import SwiftUI

struct PlayMusicView: View {
    var body: some View {
        ZStack{
            VStack{
                headerView
                musicImageView
                musicSlider
                musicController
                Spacer()
                    .scaleEffect(0)
            }
            .padding(.horizontal)
        }
        .toolbar(.hidden, for:.tabBar)
        .navigationBarBackButtonHidden(true)
        
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
     
//    func moveArtist(from source: IndexSet, to destination: Int) {
//          .move(fromOffsets: source, toOffset: destination)
//    }
//     
//    func deleteArtist(at offsets: IndexSet) {
//         .remove(atOffsets: offsets)
//    }
}

#Preview {
    PlayMusicView()
}

extension PlayMusicView {
    
    private var headerView: some View{
        HStack {
            Button{
             // modal 닫기
             //  self.presentationMode.wrappedValue.dismiss()
            } label:{
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width:20,height: 20)
                    .scaleEffect(1)
                    .foregroundColor(.black)
            }
 
            Spacer()
            Text("에너지 충전 믹스")
            Spacer()
            // right tool button 추가시
//              Image(systemName: "magnifyingglass")
//              .resizable()
//                .scaledToFit()
//                .frame(height: 20)
        }
        .frame(height: 20)
        .scaleEffect(1)
        .padding(.top,80)
        .padding(.bottom, 20)
        .padding(.horizontal, 12)
    }
    
    private var musicImageView: some View{
        VStack{
            // Image 로드시,
//            AsyncImage(url: URL(string: )){image in
//                image.resizable()
//            } placeholder: {
//                ProgressView()
//            }
            Rectangle()
            .scaledToFill()
            .frame(maxWidth:340, maxHeight: 340)
            .clipShape(Rectangle())
            .cornerRadius(10)
            .scaleEffect(1)
                //.padding(.horizontal,15)
                
            HStack{
                VStack{
                    Text("title")
                        .font(.system(size: 28))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity,alignment: .leading)
                    Text("artist")
                        .font(.system(size: 18))
                        .frame(maxWidth: .infinity,alignment: .leading)
                }
                Image(systemName: "heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width:20,height: 20)
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
                Spacer()
                Text("3:00")
            }
            .font(.system(size: 16))
            .fontWeight(.medium)
            .foregroundColor(.gray)
            .padding(.horizontal)
            
            HStack{
                Rectangle()
                    .frame(width: .infinity, height: 4)
                    .foregroundColor(Color.gray)
                    .opacity(0.3)
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
                Spacer()
                Image(systemName: "backward.end.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 24)
                Spacer()
                Image(systemName: "play.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 32)
                     
                Spacer()
                Image(systemName: "forward.end.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 24)
                Spacer()
                Image(systemName: "repeat")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 22)
                
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
