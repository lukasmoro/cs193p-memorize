//
//  CardView.swift
//  Memorize
//
//  Created by Lukas Moro on 12.02.25.
//

import SwiftUI

struct CardView: View {
    
    let card: MemorizeGame<String>.Card
    let themeColor: Color
    
    init(_ card: MemorizeGame<String>.Card, themeColor: Color) {
        self.card = card
        self.themeColor = themeColor
    }
    
    private struct Constants {
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 60
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
        struct Pie {
            static let opacity: CGFloat = 1.0
            static let inset: CGFloat = 1
        }
    }
    
    var cardContents: some View {
        Text(card.content)
            .font(.system(size: Constants.FontSize.largest))
            .minimumScaleFactor(Constants.FontSize.scaleFactor)
            .multilineTextAlignment(.center)
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(.bouncy(duration: 0.5, extraBounce: 0.2), value: card.isMatched)
    }
    
    // main/body view
    var body: some View {
        TimelineView(.animation) { timeline in
            if card.isFaceUp || !card.isMatched {
            Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                .opacity(Constants.Pie.opacity)
                .overlay(cardContents.padding(Constants.Pie.inset))
                .padding(Constants.inset)
                .cardify(isFaceUp : card.isFaceUp, themeColor: themeColor)
                .transition(.scale)
            } else {
                Color.clear
            }
        }
    }
}

typealias Card = MemorizeGame<String>.Card

#Preview {
    
    VStack{
        HStack{
            CardView(Card(isFaceUp: true, content: "🧚🏿‍♂️", id: "test1"), themeColor: Color.blue )
            CardView(Card(content: "String", id: "test1"), themeColor: Color.blue )
        }
        HStack{
            CardView(Card(isFaceUp: true, content: "🧟‍♀️👩🏼‍🍼🧚🏼‍♀️🙇🏼", id: "test1"), themeColor: Color.blue )
            CardView(Card(isMatched: true, content: "String", id: "test1"), themeColor: Color.blue )
        }
    }
    .padding()
}

