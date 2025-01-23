//
//  EmojiMemorizeGameView.swift
//  CS193p_Memorize
//
//  Created by Lukas Moro on 10.12.24.
//

import SwiftUI

struct EmojiMemorizeGameView: View {
    
    //view model pointer
    @ObservedObject var viewModel: EmojiMemorizeGame
    
    // main/body view
    var body: some View {
        VStack{
            Spacer()
            Text("MEMORIZE").font(.headline)
                .padding()
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Button("Shuffle"){
                viewModel.shuffle()
            }
            .padding()
        }
    }
    
    //card grid view
    var cards : some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0)  {
            ForEach(viewModel.cards){ card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
    }
    
    struct CardView: View {
        
        let card: MemorizeGame<String>.Card
        
        init(_ card: MemorizeGame<String>.Card) {
            self.card = card
        }
        
        // main/body view
        var body: some View {
            ZStack  {
                let base = RoundedRectangle(cornerRadius: 20)
                Group {
                    base.fill(Color.gray)
                    Text(card.content).font(.system(size:60))
                        .minimumScaleFactor(0.01)
                }
                .opacity(card.isFaceUp ? 1 : 0)
                base.fill(Color.blue)
                    .opacity(card.isFaceUp ? 0 : 1)
            }
            .opacity(card.isFaceUp || !card.isMatched ? 1:0)
        }
    }
}
    
struct EmojiMemorizeGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemorizeGameView(viewModel: EmojiMemorizeGame())
    }
}

