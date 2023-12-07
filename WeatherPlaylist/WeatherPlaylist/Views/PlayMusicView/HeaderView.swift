//
//  HeaderView.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/7/23.
//

import SwiftUI

struct HeaderView: View {
    @Environment(\.dismiss) var dismiss
    @State var title: String = ""
    var body: some View {
        HStack {
            Button{
                dismiss()
             // modal 닫기
             //  self.presentationMode.wrappedValue.dismiss()
            } label:{
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width:20,height: 20)
                    .scaleEffect(1)
                    .foregroundColor(.black)
            }
 
            Spacer()
            Text(title)
                .font(.appFont(for: .Medium, size: 14))
            Spacer()
            // right tool button 추가시
//              Image(systemName: "magnifyingglass")
//              .resizable()
//                .scaledToFit()
//                .frame(height: 20)
        }
        .frame(height: 20)
        .scaleEffect(1)
        .padding(.top,20)
        .padding(.bottom, 20)
        .padding(.horizontal, 12)
    }
}

#Preview {
    HeaderView()
}
