//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Abhas Sinha on 8/11/20.
//  Copyright © 2020 Abhas Sinha. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame {
     
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
        
        
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👻", "🤕", "😍", "🥳", "🙃", "🤩", "🤬", "🤮", "👽", "🎃"].shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 2...5)){ index in
           return emojis[index]
        }
    }
        

    
    // MARK: access to model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards.shuffle()
        return model.cards
    }
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
