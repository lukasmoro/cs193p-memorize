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
    
    //constants
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    private let radius: CGFloat = 10
    
    // main/body view
    var body: some View {
        VStack{
            VStack {
                header
                cards
            }
            HStack {
                score
                Spacer()
                reset
                shuffle
            }
            .padding()
        }
        .padding()
    }
    
    private var header : some View {
        HStack{
            Text("\(viewModel.currentThemeName)")
                .font(.title3)
            Spacer()
            Text("Memorize")
                .font(.title3.weight(.semibold))
        }
        .padding()
    }
    
    private var score : some View {
        Text("Score: \(viewModel.score)")
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
            return CardView(card, themeColor: viewModel.themeColor)
                .padding(spacing)
                .onTapGesture {
                    withAnimation {
                        viewModel.choose(card)
                    }
                }
            }
        }
    
}
    
struct EmojiMemorizeGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemorizeGameView(viewModel: EmojiMemorizeGame())
    }
}

