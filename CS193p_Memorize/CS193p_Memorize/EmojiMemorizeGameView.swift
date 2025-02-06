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
    
    private let aspectRatio: CGFloat = 2/3
    
    // main/body view
    var body: some View {
        VStack{
            Spacer()
            VStack{
                Text("Memorize: \(viewModel.currentThemeName)").font(.headline)
                .padding()
            }
            
            VStack {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            HStack {
                Text("Score: \(viewModel.score)")
                Spacer()
                Button("Reset"){
                    viewModel.reset()
                }
                .padding()
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button("Shuffle"){
                    viewModel.shuffle()
                }
                .padding()
                .background(Color.yellow)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }
    
    //card grid view
    private var cards : some View {
        AspectVGrid( viewModel.cards, aspectRatio: aspectRatio){ card in
            return CardView(card, themeColor: viewModel.themeColor)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
            }
        }
    
    struct CardView: View {
        
        let card: MemorizeGame<String>.Card
        let themeColor: Color
        
        init(_ card: MemorizeGame<String>.Card, themeColor: Color) {
            self.card = card
            self.themeColor = themeColor
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
                base.fill(themeColor)
                    .stroke(Color.white, lineWidth: 2)
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

