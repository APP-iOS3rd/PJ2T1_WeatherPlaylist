//
//  MainPageView.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/7/23.
//

import SwiftUI

struct MainPageView: View {
    
    @StateObject var viewModel: MainPageViewModel = .init()
    @State private var menutap = false
    @State var isLightMode: Bool = true
    @State var recommendedModelListIndex: Int = 0
    
    // 싱글톤 패턴으로 날씨 데이터를 가져옴
    @ObservedObject var weatherLogic = WeatherAPI.shared
    
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack{
                        if viewModel.recommendedModelList.isEmpty {
                            ProgressView("로딩 중 (\(viewModel.recommendedModelList.count)개의 항목)")
                        } else {
                            // NavigationLinks 동적으로 생성
                            topView
                            PlaylistVertical(viewModel: viewModel, recommendedModelListIndex: 0)
                            PlaylistVertical(viewModel: viewModel, recommendedModelListIndex: 1)
                        }
                    }
                    .padding(.bottom,40)
                }
                .refreshable {
                    viewModel.settingWeatherData()
                }
            }
        }
        .onAppear {
            weatherLogic.isChecking = false
        }
    }
    
    @ViewBuilder private var background: some View {
        if isLightMode {
            Color("lightBg")
                .ignoresSafeArea()
        } else {
            Color("darkBg")
                .ignoresSafeArea()
        }
    }
}

#Preview {
    MainPageView()
}


extension MainPageView {
    private var topView: some View{
        HStack (alignment:.top){
            //💁 요청 쿼리 값을 MainTitle로 사용자에게 보여주기
            Text(viewModel.mainViewTitle)//
                .font(.thin32)
                .padding(.top, 60)
                .frame(width: 200,alignment: .leading)
            Spacer()
            NavigationLink {
                MyPageView()
            }label: {
                CachedImage(url: viewModel.profileURL) {phase in
                    switch phase {
                    case .empty, .failure(_):
                        Image(uiImage: .emptyImage)
                            .resizable()
                        
                    case .success(let image):
                        image
                            .resizable()
                        
                    @unknown default:
                        Image(uiImage: .emptyImage)
                            .resizable()
                    }
                }.frame(width: 40, height: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 0.8)
                            .foregroundStyle(Color.clear)
                    )
                    .cornerRadius(20)
            }
        }.frame(maxWidth: .infinity, alignment: .leading)
            .padding(24)
    }
}

