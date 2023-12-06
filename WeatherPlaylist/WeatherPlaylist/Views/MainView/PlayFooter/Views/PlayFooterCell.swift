//
//  PlayFooterCell.swift
//  IpodSwiftUI
//
//  Created by 정정욱 on 12/6/23.
//

import SwiftUI




import SwiftUI

struct PlayFooterCell: View {
    
    var musicImage: String
    @Binding var isLightMode: Bool
    
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
            HStack(spacing: 20){
                Image(systemName: "chevron.left.2")
                Image(systemName: "play.fill")
                Image(systemName: "chevron.right.2")
            }
            .offset(x: -25, y: 0)
            
            
                
        }
        .background(
            isLightMode ? Color("lightBg") : Color("darkBg")
        )
        .ignoresSafeArea()

    }
    
}

struct PlayFooterCell_Previews: PreviewProvider {
    static var previews: some View {
        PlayFooterCell(musicImage: "album2", isLightMode: .constant(true))
    }
}
