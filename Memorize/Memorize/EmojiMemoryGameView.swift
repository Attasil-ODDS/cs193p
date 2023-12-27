//
//  ContentView.swift
//  Memorize
//
//  Created by Attasil Chitwirote on 13/12/2566 BE.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
//    var cardThemes: Array<CardTheme> = [
//        CardTheme(name:"Halloween", emojiThemes:["👻","🎃","🕷️","😈","💀"], symbol:"moon.zzz"),
//        CardTheme(name:"Vehicle", emojiThemes:["⛴️","🚀","🚁","🚂","🛩️"], symbol:"car"),
//        CardTheme(name:"Emoji", emojiThemes:["❤️‍🔥","🙏🏻","❄️","🌞","🌛","🍺"], symbol:"smiley")
//    ]
    
    @State var emojis: Array<String> =  []
    var body: some View {
        VStack {
            Text("Memorize!").font(Font.largeTitle)
            ScrollView {
                cards.animation(.default, value: viewModel.cards)
            }
            HStack(spacing: 20){
                Button("Shuffle") {
                    viewModel.shuffle()
                }
//                themeCards
            }
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 65), spacing: 0 )], spacing: 0) {
            ForEach(viewModel.cards) { card in
                VStack {
                    CardView(card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
//                    Text(card.id)
                }
            }
        }
        .foregroundColor(Color.orange)
        
    }
    
//    var themeCards: some View {
//        ForEach(cardThemes.indices, id:\.self) { index in
//            theme(name: cardThemes[index].name, emojiSelect: cardThemes[index].emojiThemes, symbol: cardThemes[index].symbol)
//        }
//    }
//    
//    func theme(name: String, emojiSelect: Array<String>, symbol: String)-> some View {
//        Button(action: {
//            emojis=(emojiSelect+emojiSelect).shuffled()
//        }) {
//            VStack{
//                Image(systemName: symbol).font(.largeTitle)
//                Text(name).font(.footnote)
//            }
//        }
//    }
}

//struct CardTheme {
//    var name: String
//    var emojiThemes: Array<String>
//    var symbol: String
//}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content).font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)

            Group {
                base.fill(.orange)
                base.strokeBorder(lineWidth: 2)
                Text(card.id).foregroundColor(.gray)
            }.opacity(card.isFaceUp ? 0 : 1)

//            base.fill().opacity(card.isFaceUp ? 0 : 1)   
        }.opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}


#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
