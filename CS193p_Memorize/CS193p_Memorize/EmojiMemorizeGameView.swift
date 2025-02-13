//
//  EmojiMemorizeGameView.swift
//  CS193p_Memorize
//
//  Created by Lukas Moro on 10.12.24.
//

import SwiftUI

struct EmojiMemorizeGameView: View {
    
    typealias Card = MemorizeGame<String>.Card
    
    //view model pointer
    @ObservedObject var viewModel: EmojiMemorizeGame
    
    //constants
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    private let radius: CGFloat = 10
    private let deckWidth: CGFloat = 50
    private let deckHeight: CGFloat = 50
    private let dealInterval: TimeInterval = 0.5
    private let dealAnimation: Animation = .easeInOut(duration: 0.5)
    
    // main/body view
    var body: some View {
        VStack{
            VStack {
                header
                cards
            }
            HStack {
                reset
                Spacer()
                deck
                Spacer()
                shuffle
            }
        }
        .padding()
    }
    
    private var header : some View {
        HStack{
            score
                .font(.title3)
            Spacer()
            Text("Memorize")
                .font(.title3.weight(.semibold))
                .foregroundStyle(.pink)
        }
        .padding()
    }
    
    private var score : some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }
    
    private var reset : some View {
        Button("Reset"){
            viewModel.reset()
        }
        .padding()
        .background(Color.purple)
        .foregroundColor(.white)
        .cornerRadius(radius)
    }
    
    private var shuffle : some View {
        Button("Shuffle"){
            withAnimation {
                viewModel.shuffle()
            }
        }
        .padding()
        .background(Color.yellow)
        .foregroundColor(.white)
        .cornerRadius(radius)
    }
    
    //card grid view
    private var cards : some View {
        AspectVGrid( viewModel.cards, aspectRatio: aspectRatio){ card in
            if isDealt(card){
                CardView(card, themeColor: viewModel.themeColor)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(spacing)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
                    .onTapGesture {
                        choose(card)
                    }
            }
        }
    }
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var unDealtCards : [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }
    
    @Namespace private var dealingNamespace
    
    private var deck: some View {
        ZStack{
            ForEach(unDealtCards){ card in
                CardView(card, themeColor: viewModel.themeColor)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: deckWidth, height: deckHeight / aspectRatio)
        .onTapGesture{
            deal()
        }
    }
    
    private func deal() {
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(dealAnimation.delay(delay)){
                _ = dealt.insert(card.id)
            }
            delay += 0.15
        }
    }
    
    @State private var lastScoreChange = (0, causedByCardId: "")
    
    private func scoreChange (causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
    
    private func choose(_ card: Card) {
        withAnimation {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            print(scoreChange)
            lastScoreChange = (scoreChange, card.id)
        }
    }
    
}
    
struct EmojiMemorizeGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemorizeGameView(viewModel: EmojiMemorizeGame())
    }
}

