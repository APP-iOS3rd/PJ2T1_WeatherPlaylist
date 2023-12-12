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
    
    // 싱글톤 패턴으로 날씨 데이터를 가져옴
    @ObservedObject var weatherLogic = WeatherLogic.shared
   

 
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack{
                        topView
                        PlaylistVertical(viewModel: viewModel)
                        // PlaylistHorizontal() 곡을 추천 하는 부분이 있어야 하나 의문..
                        PlaylistVertical(viewModel: viewModel)
                    
                    }
                    .padding(.bottom,40)
                }.refreshable {
                    viewModel.fetchPlayListModel()
                }
                // 재생중인 음악
//                PlayFooterCell()
            }
        }
        .onAppear {
            // 뷰가 나타나면서 싱글톤 객체의 속성에 접근 및 변경
            weatherLogic.isChecking = true
            weatherLogic.userWeather = .rainy
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
            //💁 날씨에 따라 표시되는 멘트가 다르게 구현
            Text(.init(weatherLogic.mainTitle))
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
                    .padding(.trailing,13)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(24)
        }
    }

