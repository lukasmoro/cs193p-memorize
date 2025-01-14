//
//  CS193p_MemorizeApp.swift
//  CS193p_Memorize
//
//  Created by Lukas Moro on 10.12.24.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            EmojiMemorizeGameView(viewModel: EmojiMemorizeGame())
        }
    }
}
