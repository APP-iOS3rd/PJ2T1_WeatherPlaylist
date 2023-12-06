
//  MainView.swift

import SwiftUI


struct MainView: View {
    @State var isLightMode: Bool = false
    
    let musicDisplayLayout: [GridItem] = [
        GridItem(.flexible(maximum: 80)),
    ]
    
    let recommendedSongLayout: [GridItem] = [
        //GridItem을 담을 수 있는 배열 생성
        // .flexible : 크기를 화면 프레임에 유연하게 늘렸다 줄었다 할 수 있게 설정
        GridItem(.flexible(), spacing: 6, alignment: nil),
    ]
    
    let imageDemo = ["album1", "album2", "album3", "album4"] // api 호출 후 삭제예정
    
  
    
    var body: some View {
        
        NavigationView {
            ZStack(alignment: .bottom) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack{
                        // Top View
                        HStack {
                            Text("화창한 날엔 이 노래 어때요?")
                                .font(.title)
                                .offset(x: 10)
                            Spacer()
                            VStack{
                                VStack{
                                    Toggle("", isOn: $isLightMode.animation(.easeInOut))
                                        .frame(width: 80, height: 17, alignment: .center)
                                        .toggleStyle(MyToggleStyle())
                                }
                                .preferredColorScheme(isLightMode ? .light : .dark)
                            }
                            .offset(x: -10)
                        }
                        // Top View End
                        
                        // PlayList Section View
                        Section{
                            // DisplayView
                            VStack(alignment: .leading){
                                VStack(alignment: .leading){
                                    
                                    //DisplayView()
                                    Text("추천 리스트")
                                        .font(.caption)
                                    Text("맞춤 믹스 : Giommy")
                                        .font(.title2)
                                }
                                .padding()
                                DisplayContent()
                                    .frame(height: 160)
                                    .offset(x: 0, y: 15)
                                
                                
                            }// DisplayView End
                            .padding(.bottom)
                            
                            // DisplayView2
                            VStack(alignment: .leading){
                                VStack(alignment: .leading){
                                    
                                    //DisplayView()
                                    Text("Woogie님을 위한 믹스 & 추천")
                                        .font(.title2)
                                }
                                .padding()
                                DisplayContent()
                                    .frame(height: 160)
                                    .offset(x: 0, y: 15)
                                
                                
                            }// DisplayView2 End
                        }
                        .padding(.bottom, 30)
                        // PlayList Section View End
                        
                        // recommendedSong Section View
                        Section{
                            VStack(alignment: .leading){
                                Text("추천 선곡")
                                    .font(.title2)
                                    .offset(x: 10)
                                
                                LazyVGrid(columns: recommendedSongLayout, spacing: 5) {
                                    ForEach(imageDemo, id: \.self) { image  in
                                        MusicCell(musicImage: image)
                                            .frame(width: 350)
                                    }
                                }
                            }
                        }
                        // recommendedSong Section View End

                    }
                    
                    .padding(.top) // 상단 패딩을 추가하여 뷰가 Safe Area 아래에서 시작하도록 설정
                    
                }
                
                // PlayFooterView Strat
                HStack(){
                    PlayFooterCell(musicImage: "album2",
                                   isLightMode: $isLightMode)
                    .frame(width: 370)
                    .cornerRadius(20)
                }
                // PlayFooterView End
                
            }
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




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}



extension Color {

    static let darkStart = Color(red: 50 / 255, green: 60 / 255, blue: 65 / 255)
    static let darkEnd = Color(red: 25 / 255, green: 25 / 255, blue: 30 / 255)
}

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topTrailing, endPoint: .bottomTrailing)
    }
}
