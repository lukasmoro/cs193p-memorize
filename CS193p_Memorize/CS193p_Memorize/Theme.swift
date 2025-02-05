//
//  Theme.swift
//  Memorize
//
//  Created by Lukas Moro on 05.02.25.
//

import SwiftUICore

struct Theme {
    let name: String
    let emojis: [String]
    let numberOfPairs: Int
    let color: Color
    
    var actualNumberOfPairs: Int {
        min(numberOfPairs, emojis.count)
    }
    
    init(name: String, emojis: [String], numberOfPairs: Int, color: Color) {
        self.name = name
        self.emojis = emojis
        self.numberOfPairs = numberOfPairs
        self.color = color
    }
}
