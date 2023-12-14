//
//  PlaylistVertical.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/7/23.
//

import SwiftUI

struct PlaylistVertical: View {
    @ObservedObject var viewModel: MainPageViewModel
    var recommendedModelListIndex: Int // 추가된 부분
    
    var body: some View {
        Section{
            HStack {
                VStack(alignment: .leading) {
                    // Display loading text while waiting for data
                    if viewModel.recommendedModelList.isEmpty {
                        ProgressView("Loading...")
                            .font(.system(size: 16, weight: .regular))
                            .padding(.bottom, 8)
                    } else {
                        // Display the title if data is available
                        if viewModel.recommendedModelList.indices.contains(recommendedModelListIndex) {
                            
                            let matchingModels = viewModel.recommendedModelList[recommendedModelListIndex]
                            if let randomModel = matchingModels.randomElement() {
                                Text("플레이리스트")
                                    .font(.system(size: 16, weight: .regular))
                                Text(randomModel.mainTitle)
                                    .font(.bold24)
                                    .padding(.bottom, 8)
                            }
                        }
                    
                    }
                }
                Spacer()
            }
            .padding(24)
            displayContent
                .frame(height: 220)
                .padding(.top,8)
            
        }
    }
}

//struct PlaylistVertical_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaylistVertical()
//            .environmentObject(MainPageViewModel())
//    }
//}

extension PlaylistVertical {
    private var displayContent: some View{
        ZStack{
            GeometryReader { fullView in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack (spacing: 30) {
                        
                        /*
                         💁 날씨에 따른 플레이리스트 가져오기 현재 날씨 == 플레이리스트 날씨 타입 일치하는 것만 가져옴
                         */
                        if viewModel.recommendedModelList.indices.contains(recommendedModelListIndex){
                            
                            ForEach(viewModel.recommendedModelList[recommendedModelListIndex].indices, id: \.self) { index in
                                let recommendedModel = viewModel.recommendedModelList[recommendedModelListIndex][index]
                                
                                    GeometryReader { geo in
                                        NavigationLink {
                                            PlaylistView(viewModel: .init(playlistInfo: recommendedModel, uid: viewModel.uid))
                                                .environmentObject(viewModel)
                                               
                                        } label: {
                                            VStack {
                                                if let img = recommendedModel.image{
                                                    CachedImage(url: URL(string: img)) { phase in
                                                        switch phase {
                                                        case .success(let img) :
                                                            img
                                                                .resizable()
                                                                .frame(width: 160, height: 160)
                                                                .cornerRadius(15)
                                                                .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
                                                        case .failure(_), .empty :
                                                            ProgressView()
                                                                .frame(width: 160, height: 160)
                                                                .cornerRadius(15)
                                                                .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
                                                        }
                                                    }
                                                }
                                                Text(recommendedModel.mainTitle)
                                                    .font(.title3)
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.colorBlack)
                                                    .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
                                                
                                                Text(recommendedModel.subitle)
                                                    .font(.subheadline)
                                                    .foregroundStyle(.colorBlack)
                                                    .fontWeight(.light)
                                                    .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
                                            }
                                        }
                                    }
                                    .frame(width: 150)
                                
                            }
                        }
                    }
                    .padding(.horizontal, (fullView.size.width - 150) / 2)
                }
            }
            .ignoresSafeArea()
        }
    }
}

