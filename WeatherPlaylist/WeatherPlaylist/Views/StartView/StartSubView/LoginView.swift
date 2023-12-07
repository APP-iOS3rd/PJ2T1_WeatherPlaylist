//
//  LoginView.swift
//  WeatherPlaylist
//
//  Created by 김성엽 on 12/6/23.
//

import SwiftUI

struct LoginView: View {
    @State var showWK = false
    
    
    var body: some View {
        NavigationView {
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
                        
                        Button(action: {
                            self.showWK.toggle()
                            
                        }, label: {
                            Text("스포티파이로 시작하기")
                                .font(.custom(FontType.SemiBold.rawValue, size: 20))
                                .foregroundStyle(.black)
                                .sheet(isPresented: $showWK) {
                                    AuthView()
                                }
                        })
                        .buttonStyle(signUptButton())
                        Spacer()
                        


                        
                        //                        NavigationLink {
                        //                            EmptyView()
                        //                        } label: {
                        //                            HStack {
                        //                                Text("스포티파이로 시작하기")
                        //                                    .font(.custom(FontType.SemiBold.rawValue, size: 20))
                        //                                    .foregroundStyle(.black)
                        //                            }
                        //                        }
                        //                        .buttonStyle(signUptButton())
                        //                        Spacer()
                        //                    }
                    }
                }
            }
        }
    }
    func didTapSignIn() {
        var vc = AuthView()
        vc.completionHandler = { success in
            DispatchQueue.main.async {
                self.handleSignIn(success: success)
            }
            
        }
    }
    
    private func handleSignIn(success: Bool) {
        
    }
    
}



struct signUptButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding(.vertical, 20)
            .padding(.horizontal, 70)
            .background(.colorGreen)
            .cornerRadius(40)
    }
}


//
//#Preview {
//    LoginView()
//}
