//
//  FlyingNumber.swift
//  Memorize
//
//  Created by Lukas Moro on 12.02.25.
//

import SwiftUI

struct FlyingNumber: View {
    let number: Int
    var body: some View {
        if number != 0 {
            Text(number, format: .number.sign(strategy: .always()))
                .font(.largeTitle.weight(.bold))
                .foregroundStyle(number < 0 ? Color(.systemRed) : Color(.systemGreen))
                .shadow(color: number < 0 ? Color(.systemRed) : Color(.systemGreen), radius: 2.5, x:0, y:1)
        }
    }
}
