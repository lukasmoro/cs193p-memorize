//
//  ContentView.swift
//  CS193p_Memorize
//
//  Created by Lukas Moro on 10.12.24.
//

import SwiftUI

struct ContentView: View {
    
    @State var cardCount = 3
    let emojis = ["🦋", "🪲", "🐝", "🐞", "🕷️", "🪰", "🐜", "🪳", "🦂"]
    
    var body: some View {
        VStack{
            Spacer()
            cards
            Spacer()
            cardCountAdjusters
        }
        
    }
    
    var cards : some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))])  {
            ForEach(0..<cardCount, id: \.self){ index in
                CardView(content: emojis[index])
                    .aspectRatio(1/1, contentMode: .fit)
            }
        }
        .padding()
    }
    
    var cardCountAdjusters : some View {
        HStack{
            cardAdder
            Spacer()
            cardRemover
        }
        .imageScale(.large)
        .padding()
    }
    
    func cardCountAdjuster(by offset : Int, symbol : String ) -> some View{
        Button(action:{cardCount += offset},label:{Image(systemName: symbol)})
            .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardRemover : some View {
        cardCountAdjuster(by: -1, symbol: "minus.circle")
    }
    
    var cardAdder : some View {
        cardCountAdjuster(by: 1, symbol: "plus.circle")
    }
}

struct CardView: View {
   
    @State var isFaceUp = true
    var content = "🦋"
    
    var body: some View {
        ZStack  {
            let base = RoundedRectangle(cornerRadius: 30)
            Group {
                base.fill(Color.gray)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill(Color.blue).opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            print("tapped")
            isFaceUp .toggle()
        }
    }
    
}






























#Preview {
    ContentView()
}
