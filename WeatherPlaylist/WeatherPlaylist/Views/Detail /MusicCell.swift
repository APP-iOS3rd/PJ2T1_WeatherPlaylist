//
//  MusicCell.swift
//  IpodSwiftUI
//
//  Created by 정정욱 on 12/5/23.
//


import SwiftUI

struct MusicCell: View {
    var musicImage: String
    
    var body: some View{
    
        
        HStack(spacing: 20){
            Image(musicImage)
                .resizable()
                .scaledToFit()
                .frame(width: 60)
            VStack(alignment: .leading){
                Text("노래 제목")
                Text("가수 이름 3:14")
            }
            
            Spacer()
            Image(systemName: "ellipsis")
                .rotationEffect(Angle(degrees: 90))
                
        }
    }
}

#Preview {
    MusicCell(musicImage: "album1")
}
