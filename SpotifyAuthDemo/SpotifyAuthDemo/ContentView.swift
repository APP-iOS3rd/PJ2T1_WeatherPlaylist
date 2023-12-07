//
//  ContentView.swift
//  SpotifyAuthDemo
//
//  Created by 김성엽 on 12/7/23.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = WebViewModel()
    @State var bar = true
    
    var body: some View {
        VStack {
            WebView(viewModel: viewModel)
            
            HStack {
                Text(bar ? "Before" : "After")
            
                Button(action: {
                    self.viewModel.foo.send(true)
                }) {
                    Text("보내기")
                }
            }
        }
        .onReceive(self.viewModel.bar.receive(on: RunLoop.main)) { value in
            self.bar = value
        }
    }
}

#Preview {
    ContentView()
}
