//
//  ContentView.swift
//  Memorize
//
//  Created by Attasil Chitwirote on 13/12/2566 BE.
//

import SwiftUI

struct ContentView: View {
    let emojis: Array<String> = ["👻","🎃","🕷️","😈","😈"]
    var body: some View {
        HStack{
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
            }
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = false
    
    var body: some View {
        ZStack {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            } else {
                base.fill()
            }
        }.onTapGesture {
            isFaceUp.toggle()
            print(content+" -- tapped")
        }
    }
}


#Preview {
    ContentView()
}
