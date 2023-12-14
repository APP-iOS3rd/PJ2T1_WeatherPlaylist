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
    
    @Environment(\.dismiss) var dismiss
    
    @State private var isShowingPlayer = false
    @StateObject var viewModel: PlayMusicViewModel  = .init()
    @StateObject var player = PlayerManager.shared
    
    var body: some View {
        NavigationStack {
            HeaderView(title: viewModel.playMusicModel.playlistTitle)
            ZStack {
                VStack {
                    musicImageView
                    musicSlider
                    musicController
                    Spacer()
                        .scaleEffect(0)
                }
                .padding(.horizontal)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            // .background(Color.lightBg)
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
        .gesture(
            DragGesture().onEnded{ value in
                if value.location.y - value.startLocation.y > 150 {
                    dismiss()
                }
            }
        )
        
        .background(Color.lightBg)
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
            //            CachedImage(url: nil){ phase in
            //                switch phase {
            //                case .success(let image) :
            //                    image.resizable()
            //                case .empty, .failure(_) :
            //                    ProgressView()
            //                }
            //            }
            AsyncImage(url:
                        URL(string: player.track?.coverImage ?? "")) {
                image in
                image
                    .resizable()
                    .padding(8)
                
            } placeholder: {
                ProgressView()
            }
            .scaledToFill()
            .frame(maxWidth:340, maxHeight: 340)
            .clipShape(Rectangle())
            .cornerRadius(10)
            .scaleEffect(1)
            //.padding(.horizontal,15)
            
            HStack{
                VStack{
                    Text(player.track?.songName ?? "")
                        .font(.bold28)
                        .frame(maxWidth: .infinity,alignment: .leading)
                    Text(player.track?.artist ?? "")
                        .font(.regular18)
                        .frame(maxWidth: .infinity,alignment: .leading)
                }
                Image(systemName: "heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width:20,height: 20)
                //MARK: - 살짝 커졌다 작아지는 애니메이션?
                    .scaleEffect(1)
                
            }
            .padding(.vertical,24)
            .padding(.horizontal)
            
        }
        //.padding()
        
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
            
            HStack{
//                HStack {
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
                    
                    Spacer()
//                }
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
                        if let playlist = player.tracks {
                            ForEach(playlist.indices, id: \.self) { index in
                                HStack{
                                    let playlistModel = playlist[index]
                                    
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
                                .listRowBackground(Color.gray.opacity(0.7))
                                .onTapGesture {
                                    player.playTrack(track: playlist[index], 
                                                     playlistID: player.currentPlaylistID,
                                                     tracklist: player.tracks!)
                                }
                            }
//                            .onMove(perform: moveTrack)
//                            .onDelete(perform: deleteTrack)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    
                }
                .background(Color.gray.opacity(0.9))
//                .toolbar {
//                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
//                        EditButton()
//                    }
//                }
            }
            
            
        }
    }
    
}
