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
    @ObservedObject var weatherLogic = WeatherLogic.shared
    
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack{
                    
                        if viewModel.recommendedModelList.isEmpty {
                            ProgressView() // 값이 없을 때 기다림을 나타내는 ProgressView
                        } else {
                            // NavigationLinks 동적으로 생성
                            topView
                            PlaylistVertical(viewModel: viewModel, recommendedModelListIndex: 0)
                            PlaylistVertical(viewModel: viewModel, recommendedModelListIndex: 1)
                        }
                        
                        
                    }
                    .padding(.bottom,40)
                }.refreshable {
                    viewModel.settingWeatherData()
//                    print("문제가 뭘까?\(viewModel.RecommendedModelList)"
//                    )
                    // 쿼리 질의문 까지 같이 변경하여
                    // 바꾼 쿼리로 스포티파이 API 호출 후 리스트 가져오기
                }
            }
        }
        .onAppear {
            weatherLogic.isChecking = true
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
        HStack {
            //💁 요청 쿼리 값을 MainTitle로 사용자에게 보여주기
            Text(viewModel.mainViewTitle)//
                .font(.thin32)
                .padding(.top, 12)
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

