//
//  ContentView.swift
//  CS193p_Memorize
//
//  Created by Lukas Moro on 10.12.24.
//

import SwiftUI

struct ContentView: View {
    
    let emojis = ["🦋", "🪲", "🐝"]
    
    var body: some View {
        HStack  {
            ForEach(emojis.indices, id: \.self){ index in
                CardView(content: emojis[index])
            }
        }
        .padding()
    }
}

struct CardView: View {
   
    @State var isFaceUp = true
    var content = "🦋"
    
    var body: some View {
        ZStack  {
            let base = RoundedRectangle(cornerRadius: 30)
            
            if isFaceUp{
                base.foregroundColor(Color.gray)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            else{
                base.foregroundColor(Color.blue)
            }
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
