//
//  PlaylistVertical.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/7/23.
//

import SwiftUI

struct PlaylistVertical: View {
    @ObservedObject var viewModel: MainPageViewModel = MainPageViewModel()
    
    @ObservedObject var weatherLogic = WeatherLogic.shared
    
    var body: some View {
        Section{
            HStack{
                /*
                 💁  날씨에 따라 표시되는 멘트가 다르게 구현 API 호출 후 날씨에 따라 제목과 부제목 뿌려주면될 거 같습니다다.
                 
                 싱글 톤 패턴으로 현재 날씨와 플리안 날씨 데이터 타입이 일치하는 것으로 멘트 뿌리기
                 (좀 더 의논해 볼 필요가 있음 현재 임시로 플레이리스트 제목을가져왔지만, 그냥 날씨에 따라 멘트만 모아놓는 구조체가 하나필요할 거 같음 )
                 */
                VStack(alignment: .leading){
                    // 날씨에 따른 추천 플레이리스트 제목
                    let matchingModels = viewModel.recommendedModelList.filter { $0.weatherType == weatherLogic.userWeather }
                    if let randomModel = matchingModels.randomElement() {
                        Text(randomModel.mainTitle)
                            .font(.system(size: 16, weight: .regular))
                    }
                    
                    // 날씨에 따른 추천 플레이리스트 부제목
                    Text(viewModel.recommendedModelList[0].subitle)
                        .font(.bold20)
                }
                Spacer()
            }.padding(24)
            
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
                        
                        ForEach(viewModel.recommendedModelList.indices, id: \.self) { index in
                            let recommendedModel = viewModel.recommendedModelList[index]
                            
                            if weatherLogic.userWeather == recommendedModel.weatherType {
                                GeometryReader { geo in
                                    NavigationLink {
                                        PlaylistView(viewModel: .init(playlistInfo: recommendedModel, uid: viewModel.uid))
                                            .environmentObject(viewModel)
                                            .navigationTitle(recommendedModel.mainTitle)
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



