//
//  LoginView.swift
//  WeatherPlaylist
//
//  Created by 김성엽 on 12/11/23.
//

import SwiftUI

struct LoginView: View {
    @State var path: [StackViewType] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            GeometryReader { reader in
                ZStack {
                    
                    Image("background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: reader.size.width)
                        .ignoresSafeArea()
                    
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(
                            LinearGradient(
                                gradient: Gradient( colors: [
                                    .clear,
                                    .colorBlack
                                ]
                                                    
                                ),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    
                    VStack(spacing: 20) {
                        Spacer()
                        Image("spotify")
                            .resizable()
                            .scaledToFit()
                            .frame(width:50)
                        
                        
                        Text("내 마음에 꼭 드는 또 다른 플레이리스트를 발견해보세요.")
                            .padding(.horizontal, 15)
                            .font(.custom(FontType.Bold.rawValue, size: 40))
                            .foregroundStyle(.white)
                        
                        Spacer()
                        
                        
                        Button {
                            if let token = UserDefaults.standard.value(forKey: "Authorization") {
                                path.append(.secondView)
                                print(token)
                            } else {
                                path.append(.firstView)
                            }
                            
                        } label: {
                            Text("스포티파이로 시작하기")
                                .font(.custom(FontType.SemiBold.rawValue, size: 20))
                                .foregroundStyle(.black)
                                .padding(.vertical, 20)
                                .padding(.horizontal, 70)
                                .background(.colorGreen)
                                .cornerRadius(40)
                        }
                        Spacer()
                        Button(action: {
                            UserDefaults.standard.removeObject(forKey: "Authorization")
                        }, label: {
                            Text("token 삭제")
                        })
                        
                    }
                    .navigationDestination(for: StackViewType.self) { stackViewType in
                        switch stackViewType {
                        case .firstView:
                            AuthView()
                        case .secondView:
                            MainPageView()
                        }
                    }
                }
            }
        }
    }
}
