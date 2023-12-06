//
//  DisPlayView.swift
//  WeatherPlaylist
//
//  Created by 정정욱 on 12/6/23.
//

import SwiftUI


//Geometry Reader : Album View
struct DisplayContent: View {
    
    
    // Dummy Data
    var images : [UIImage]! = [
        UIImage(named: "album1")!,
        UIImage(named: "album2")!,
        UIImage(named: "album3")!,
        UIImage(named: "album4")!,
        UIImage(named: "album5")!,
        UIImage(named: "album6")!,
        UIImage(named: "album7")!,
    ]
    
    
    let albumName : [String] = ["Music To Be..",
                                "Justice",
                                "Dua Lipa",
                                "X",
                                "Natural Causes",
                                "Escape" ,
                                "Red"]
    
    let albumArtist : [String] = ["Eminem",
                                  "Justin Bieber",
                                  "Dua Lipa",
                                  "Ed Sheeran",
                                  "Skyler Grey",
                                  "Enrique Iglesias" ,
                                  "Taylor Swift"]
    
    var body: some View {
        
        
        ZStack{
            GeometryReader { fullView in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack (spacing: 30) {
                        ForEach(0..<20) { index in
                            GeometryReader { geo in
                                
                                // Detail View
                                NavigationLink { // 버튼이랑 비슷함
                                    // destination : 목적지 -> 어디로 페이지 이동할꺼냐
                                    DetailView()
                                }label: {
                                    VStack{
                                        Image(uiImage:self.images[index % 7])
                                            .resizable()
                                            .frame(width: 160, height: 160)
                                            .cornerRadius(15)
                                            .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
                                        
                                        
                                        
                                        
                                        Text(self.albumArtist[index % 7])
                                            .font(.title3)
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.white)
                                            .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
                                        
                                        
                                        Text(self.albumName[index % 7])
                                            .font(.subheadline)
                                            .fontWeight(.light)
                                            .foregroundColor(Color.white)
                                            .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
                                        
                                    }
                                }
                            }
                            .frame(width: 150)
                            // Detail View End
                        }
                    }
                    .padding(.horizontal, (fullView.size.width - 150) / 2)
                    
                }
            }
            .ignoresSafeArea()
            
            
        }
    }
}




//Menu Content
struct MenuContent: View {
    @State var textinput : String = "Hello"
    @State var bgColor : Color = Color.blue
    
    
    
    
    var body: some View {
        HStack{
            Text(textinput)
                .font(.title)
            
            Spacer()
            
            Image(systemName: "chevron.forward")
        }.foregroundColor(bgColor)
            .padding(10)
    }
}
