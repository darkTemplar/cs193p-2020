//
//  EmojiMemoryGameThemes.swift
//  Memorize
//
//  Created by Abhas Sinha on 8/22/20.
//  Copyright © 2020 Abhas Sinha. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameTheme {
    var name: String
    var emojiSet: Array<String>
    var numberOfPairsOfCards: Int
    var color: Color
    
    init(name: String, numberOfPairsOfCards: Int?, emojiSet: Array<String>, color: Color) {
        self.name = name
        self.emojiSet = emojiSet
        if let numCards = numberOfPairsOfCards {
            self.numberOfPairsOfCards = numCards
        } else {
            self.numberOfPairsOfCards = Int.random(in: 2...emojiSet.count)
        }
        self.color = color
    }
}
