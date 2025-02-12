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
        static let cornerRadius: CGFloat = 20
        static let lineWeight: CGFloat = 2
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
    
    // main/body view
    var body: some View {
        ZStack  {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            Group {
                base.fill(Color.gray)
                Pie(endAngle: .degrees(240))
                    .opacity(Constants.Pie.opacity)
                    .overlay(
                        Text(card.content)
                            .font(.system(size: Constants.FontSize.largest))
                            .minimumScaleFactor(Constants.FontSize.scaleFactor)
                            .multilineTextAlignment(.center)
                            .padding(Constants.Pie.inset)
                        )
                    .padding(Constants.inset)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill(themeColor)
                .stroke(Color.white, lineWidth: Constants.lineWeight)
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
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

