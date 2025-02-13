//
//  Cardify.swift
//  Memorize
//
//  Created by Lukas Moro on 12.02.25.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    
    
    init(isFaceUp: Bool, themeColor: Color) {
        rotation = isFaceUp ? 0 : 180
        self.themeColor = themeColor
    }
    
    var isFaceUp: Bool{
        rotation < 90
    }
    let themeColor: Color
    
    var rotation: Double
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 20
        static let lineWeight: CGFloat = 2
    }
    
    func body(content: Content) -> some View{
        ZStack  {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            base.strokeBorder(Color.blue, lineWidth: Constants.lineWeight)
                .background(base.fill(Color(.systemGray6)))
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            base.fill(themeColor)
                .stroke(Color.white, lineWidth: Constants.lineWeight)
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(.degrees(rotation), axis: (0,1,0))
    }
}

extension View {
    func cardify(isFaceUp: Bool, themeColor: Color) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp, themeColor: themeColor))
    }
}
