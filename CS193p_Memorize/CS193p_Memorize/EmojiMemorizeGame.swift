//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Lukas Moro on 14.01.25.
//

import SwiftUI

class EmojiMemorizeGame: ObservableObject {
    
    typealias Card = MemorizeGame<String>.Card
    
    private static let themes = [
        Theme(
            name: "Insects",
            emojis: ["🦋", "🪲", "🐝", "🐞", "🕷️", "🪰", "🐜", "🪳", "🦂"],
            numberOfPairs: 8,
            color: .blue
        ),
        Theme(
            name: "Architecture",
            emojis: ["🕌", "🏢", "⛩️", "🛖", "🏛️", "🗼", "🛕", "🕋", "🏯"],
            numberOfPairs: 8,
            color: .yellow
        ),
        Theme(
            name: "Animals",
            emojis: ["🐊", "🐬", "🦓", "🦒", "🐡", "🦀", "🐂", "🦧", "🦣"],
            numberOfPairs: 8,
            color: .purple
        ),
        Theme(
            name: "Symbols",
            emojis: ["💟", "☮️", "🕉️", "✡️", "☯️", "🕎", "♋️", "♒️", "🪯"],
            numberOfPairs: 8,
            color: .green
        ),
        Theme(
            name: "Characters",
            emojis: ["🧚🏼‍♀️", "🧜🏻‍♀️", "🧟‍♀️", "🧞‍♂️", "🧛🏼", "👼🏾", "👨🏽‍🎨", "👮🏼‍♂️", "👩🏽‍🎤"],
            numberOfPairs: 8,
            color: .orange
        ),
        Theme(
            name: "Flags",
            emojis: ["🇦🇫", "🇧🇾", "🇧🇷", "🇬🇷", "🇲🇪", "🇰🇳", "🇺🇾", "🇺🇸", "🇬🇧"],
            numberOfPairs: 8,
            color: .gray
        )
    ]
        
    @Published private var model: MemorizeGame<String>
    @Published private var currentTheme: Theme
    
    init(){
        let initialTheme = Self.themes.randomElement()!
        self.currentTheme = initialTheme
        self.model = Self.createMemorizeGame(theme: initialTheme)
    }
    
    private static func createMemorizeGame(theme: Theme) -> MemorizeGame<String>  {
        return MemorizeGame(numberOfPairsOfCards: theme.actualNumberOfPairs) { pairIndex in
            if theme.emojis.indices.contains(pairIndex) {
                return theme.emojis[pairIndex]
            } else {
                return "😵"
            }
        }
    }
    
    var currentThemeName: String {
        currentTheme.name
    }
    
    var themeColor: Color {
        currentTheme.color
    }
    
    var cards: Array<Card> {
        return model.cards
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func reset() {
        currentTheme = Self.themes.randomElement()!
        model = Self.createMemorizeGame(theme: currentTheme)
        shuffle()
    }
}
