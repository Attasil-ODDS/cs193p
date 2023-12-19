//
//  ContentView.swift
//  Memorize
//
//  Created by Attasil Chitwirote on 13/12/2566 BE.
//

import SwiftUI

struct ContentView: View {
    var cardThemes: Array<CardTheme> = [
        CardTheme(name:"Halloween", emojiThemes:["👻","🎃","🕷️","😈","💀"], symbol:"moon.zzz"),
        CardTheme(name:"Vehicle", emojiThemes:["⛴️","🚀","🚁","🚂","🛩️"], symbol:"car"),
        CardTheme(name:"Emoji", emojiThemes:["❤️‍🔥","🙏🏻","❄️","🌞","🌛","🍺"], symbol:"smiley")
    ]
    @State var cardCount: Int = 8
    @State var emojis: Array<String> =  []
    var body: some View {
        VStack{
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
            }
            HStack(spacing: 20){
                themeCards
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
    
    var themeCards: some View {
        ForEach(cardThemes.indices, id:\.self) { index in
            theme(name: cardThemes[index].name, emojiSelect: cardThemes[index].emojiThemes, symbol: cardThemes[index].symbol)
        }
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

struct CardTheme {
    var name: String
    var emojiThemes: Array<String>
    var symbol: String
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
