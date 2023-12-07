//
//  DisplayView.swift
//  WeatherPlaylist
//
//  Created by 김소혜 on 12/7/23.
//

import SwiftUI

struct DisplayContent: View {
    
    // Dummy Data
//    var images : [UIImage]! = [
//        UIImage(named: "album1")!,
//    ]

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
                        ForEach(0..<10) { index in
                            GeometryReader { geo in
                                NavigationLink {
                                    //DetailView()
                                }label: {
                                    VStack{
//                                        Image(uiImage:self.images[index % 7])
//                                            .resizable()
//                                            .frame(width: 160, height: 160)
//                                            .cornerRadius(15)
//                                            .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
//                                        
                                        Rectangle()
                                       // .resizable()
                                        .frame(width: 160, height: 160)
                                        .cornerRadius(15)
                                        .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
                                        
                                        Text("title")
                                            .font(.title3)
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.white)
                                            .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
                                        
                                        Text("artist")
                                            .font(.subheadline)
                                            .fontWeight(.light)
                                            .foregroundColor(Color.white)
                                            .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
                                        
                                    }
                                }
                            }
                            .frame(width: 150)
                        }
                    }
                    .padding(.horizontal, (fullView.size.width - 150) / 2)
                }
            }
            .ignoresSafeArea()
        }
    }
}


#Preview {
    DisplayContent()
}
