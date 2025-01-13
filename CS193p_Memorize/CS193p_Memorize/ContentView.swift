//
//  ContentView.swift
//  CS193p_Memorize
//
//  Created by Lukas Moro on 10.12.24.
//

import SwiftUI

struct ContentView: View {
    
    // state properties
    @State var currentEmojis = ["🦋", "🪲", "🐝", "🐞", "🕷️", "🪰", "🐜", "🪳", "🦂"] + ["🦋", "🪲", "🐝", "🐞", "🕷️", "🪰", "🐜", "🪳", "🦂"].shuffled()
    
    // variables, theme arrays
    let insects = ["🦋", "🪲", "🐝", "🐞", "🕷️", "🪰", "🐜", "🪳", "🦂"]
    let architecture = ["🏯", "⛩️", "🏛️", "🗼", "🏢", "🕌", "🏠", "🛖", "🛕"]
    let food = ["🥑", "🥦", "🫐", "🥐", "🍖", "🥩", "🍰", "🫛", "🍉"]
    
    // main/body view
    var body: some View {
        VStack{
            Spacer()
            Text("MEMORIZE!").font(.headline)
            Spacer()
            cards
            Spacer()
            toolBar
        }
    }
    
    //card grid view
    var cards : some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))],
                      spacing: 10)  {
                ForEach(currentEmojis.indices, id: \.self){ index in
                    CardView(content: currentEmojis[index])
                        .aspectRatio(1/1, contentMode: .fit)
                }
            }
            .padding()
        }
    }
    
    // toolbar view
    var toolBar : some View {
        HStack{
            Spacer()
            HStack{
                insectSwitcher
                architectureSwitcher
                foodSwitcher
            }
            Spacer()
        }
        .imageScale(.large)
        .padding()
    }
    
    //theme switcher function
    func themeSwitcher(theme: [String], symbol: String, description: String) -> some View {
        HStack{
            VStack{
                Button(action: {
                    currentEmojis = (theme + theme).shuffled()
                }, label: {
                    Image(systemName: symbol)
                })
                Text(description).font(.caption)
            }
        }
    }
    
    var insectSwitcher: some View {
        themeSwitcher(theme: insects, symbol: "ant", description: "insects")
    }
    
    var architectureSwitcher: some View {
        themeSwitcher(theme: architecture, symbol: "building.2", description: "architecture")
    }
    
    var foodSwitcher: some View {
        themeSwitcher(theme: food, symbol: "fork.knife", description: "food")
    }
}

struct CardView: View {
    
    // state properties
    @State var isFaceUp = false
    
    // variables
    var content = "🦋"
    
    // main/body view
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
            isFaceUp .toggle()
        }
    }
}

#Preview {
    ContentView()
}
