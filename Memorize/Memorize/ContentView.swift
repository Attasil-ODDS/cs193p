//
//  ContentView.swift
//  Memorize
//
//  Created by Attasil Chitwirote on 13/12/2566 BE.
//

import SwiftUI

struct ContentView: View {
    let emojiHalloweens: Array<String> = ["👻","🎃","🕷️","😈","💀"]
    let emojiVehicles: Array<String> = ["⛴️","🚀","🚁","🚂","🛩️"]
    let emojiStatus: Array<String> = ["❤️‍🔥","🙏🏻","❄️","🌞","🌛","🍺"]
    @State var cardCount: Int = 8
    @State var emojis: Array<String> =  []
    var body: some View {
        VStack{
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
            }
            HStack(spacing: 20){
                theme(name: "Halloween", emojiSelect: emojiHalloweens, symbol: "person.crop.circle.badge.moon")
                theme(name: "Halloween", emojiSelect: emojiVehicles, symbol: "car")
                theme(name: "Halloween", emojiSelect: emojiStatus, symbol: "smiley")
            }
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    func theme(name: String, emojiSelect: Array<String>, symbol: String)-> some View {
        Button(action: {
            emojis=(emojiSelect+emojiSelect).shuffled()
        }) {
            VStack{
                Image(systemName: symbol).font(.largeTitle)
                Text(name).font(.footnote)
            }
        }
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = false
    
    var body: some View {
        ZStack {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            isFaceUp.toggle()
            print(content+" -- tapped")
        }
    }
}


#Preview {
    ContentView()
}
