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
    @ViewBuilder
    var cards : some View {
        let aspectRadio: CGFloat = 2/3
        GeometryReader { geometry in
            let gridItemSize: CGFloat = gridItemWidthThatFits(
                count: viewModel.cards.count,
                size: geometry.size,
                atAspectRatio: aspectRadio
            )
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0)  {
                ForEach(viewModel.cards){ card in
                    CardView(card, themeColor: viewModel.themeColor)
                        .aspectRatio(aspectRadio, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
    }
    
    func gridItemWidthThatFits(
        count: Int,
        size: CGSize,
        atAspectRatio aspectRatio: CGFloat
    ) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            let rowCount = (count / columnCount).rounded(.up)
            
            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            
            columnCount += 1
        } while columnCount < count
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
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

