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
        let numberOfPairsOfCards = Int.random(in: 2...5)
        let emojis = ["👻", "🤕", "😍", "🥳", "🙃"]
        let inGameEmojis = Array(emojis[0..<numberOfPairsOfCards])
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCards){ index in
           return inGameEmojis[index]
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
