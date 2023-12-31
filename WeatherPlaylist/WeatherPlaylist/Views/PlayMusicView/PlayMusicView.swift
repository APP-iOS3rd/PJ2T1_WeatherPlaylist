//
//  PlayMusicView.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/6/23.
//

import SwiftUI

struct PlayMusicView: View {
    @State var temp: PlaylistTrackModel
    
    @Environment(\.dismiss) var dismiss
    
    @State private var isShowingPlayer = false
    @StateObject var viewModel: PlayMusicViewModel  = .init()
    @StateObject var player = PlayerManager.shared
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
  
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    var body: some View {
 
        NavigationStack{
            HeaderView()
            VStack {
                musicImageView
            }
            .padding(.horizontal)
            .bottomDrawerView(
                bottomDrawerHeight: 70,
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
        .gesture(
            DragGesture().onEnded{ value in
                if value.location.y - value.startLocation.y > 150 {
                    dismiss()
                }
            }
        )
    }
     
    
//    func moveTrack(from source: IndexSet, to destination: Int) {
//        viewModel.playlistModelList.move(fromOffsets: source, toOffset: destination)
//    }
//    
//    func deleteTrack(at offsets: IndexSet) {
//        viewModel.playlistModelList.remove(atOffsets: offsets)
//    }
    
    @ViewBuilder
    var musicImageView: some View{
        if verticalSizeClass == .compact {
            GeometryReader{ proxy in
                VStack(alignment: .center){
                    HStack{
                        albumImage
                            .frame(width: proxy.size.height * 0.6,height: proxy.size.height  * 0.6)
                        Spacer()
                        VStack{
                            albumText
                            musicController
                            musicSlider
                        }.frame(width: proxy.size.width * 0.67)
                    }
                }
            }.padding(safeAreaInsets)
                
        } else{
            GeometryReader{ proxy in
                VStack {
                    albumImage
                        .frame(width: proxy.size.width * 0.95,height: proxy.size.width * 0.95)
                    albumText
                    musicSlider
                    musicController
                }
            }.padding(0)
        }
    }
}

//#Preview {
//    PlayMusicView()
//}

extension PlayMusicView {
    private var albumImage: some View {
            
        AsyncImage(url:
                    URL(string: player.track?.coverImage ?? "")) {
            image in
            image
                .resizable()
                .aspectRatio(1, contentMode: .fit)
        } placeholder: {
            ProgressView()
        }
      //  .scaledToFill()
        .cornerRadius(10)
        .clipShape(Rectangle())
        .padding(.vertical,0)
        .padding(.horizontal,8)
    }
    private var albumText: some View{
        HStack{
            VStack{
                Text(player.track?.songName ?? "")
                    .font(.bold24)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity,alignment: .leading)
                Text(player.track?.artist ?? "")
                    .font(.regular18)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity,alignment: .leading)
            }
            Image(systemName: "heart")
                .resizable()
                .scaledToFit()
                .frame(width:20,height: 20)
            //MARK: - 살짝 커졌다 작아지는 애니메이션?
                .scaleEffect(1)
            
        }
        .padding(.vertical,0)
        .padding(.horizontal)
    }
    
    private var musicSlider: some View{
        VStack{
            HStack{
                Text(player.getTime(songDuration: player.songTime))
                    .font(.medium16)
                Spacer()
                Text("0:30")
                    .font(.medium16)
            }
            .font(.system(size: 16))
            .fontWeight(.medium)
            .foregroundColor(.gray)
            .padding(.horizontal)
            .offset(y:8)
            
            HStack{
             
                Slider(value: $player.songTime,
                       in: 0...30,
                       step: 1,
                       onEditingChanged: { data in
                    if data == true {
                        player.pause()
                        let value = player.songTime
                        player.changeTime(time: value)
                    } else {
                        let value = player.songTime
                        player.changeTime(time: value)
                        player.play()
                    }
                })
            }
            .padding(.horizontal)
        }
        .padding(.top, 4)
        .padding(.horizontal, 0)
        
    }
    
    private var musicController:some View{
        VStack{
            
            HStack{
                Image(systemName: "shuffle")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(player.isShuffling ? .accent : .colorBlack)
                    .frame(height: 22)
                    .onTapGesture {
                        player.isShuffling.toggle()
                    }
                Spacer()
                Image(systemName: "backward.end.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.colorBlack)
                    .frame(height: 24)
                    .onTapGesture {
                        player.goPrevTrack()
                    }
                Spacer()
                Image(systemName: player.isPlaying ? "pause.fill" : "play.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.colorBlack)
                    .frame(height: 32)
                    .onTapGesture {
                        if player.isPlaying {
                            player.pause()
                        } else {
                            player.play()
                        }
                    }
                
                Spacer()
                Image(systemName: "forward.end.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.colorBlack)
                    .frame(height: 24)
                    .onTapGesture {
                        player.goNextTrack()
                    }
                Spacer()
                Image(systemName: "repeat")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(player.isRepeating ? .accent : .colorBlack)
                    .frame(height: 22)
                    .onTapGesture {
                        player.isRepeating.toggle()
                    }
                
            }.padding()
        }
    }
    
    private var bottomDrawer:some View{
        ZStack {
            Color.gray.opacity(0.9)
            NavigationView {
                VStack{
                    List {
                        if let tracks = PlayerManager.shared.tracks {
                            ForEach(tracks.indices, id: \.self) { index in
                                HStack{
                                    
                                    let playlistModel = tracks[index]
      
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
                                            .foregroundStyle(playlistModel.songName == player.track?.songName ? .accent : .colorBlack)
                                        Text(playlistModel.artist)
                                            .font(.body)
                                            .foregroundStyle(playlistModel.songName == player.track?.songName ? .accent : .colorBlack)
                                    }
                                }
                                .onTapGesture {
                                    player.playTrack(track: tracks[index],
                                                     playlistID: tracks[index].id,
                                                            tracklist: tracks
                                    )
                                    self.isShowingPlayer.toggle()
                                }
                                .listRowBackground(Color.gray.opacity(0.7))
                            }
                        }
                    }.scrollContentBackground(.hidden)
                    
                }.background(Color.gray.opacity(0.9))

            }
            
        }
    }
    
}
 
