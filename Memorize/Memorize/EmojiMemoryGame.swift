//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Abhas Sinha on 8/11/20.
//  Copyright © 2020 Abhas Sinha. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private var gameTheme: EmojiMemoryGameTheme
    @Published private var model: MemoryGame<String>
        
    
    init() {
        var gameTheme = EmojiMemoryGame.chooseGameTheme()
        // shuffle emojis to get a diff. bunch each time
        gameTheme.emojiSet.shuffle()
        model = MemoryGame<String>(numberOfPairsOfCards: gameTheme.numberOfPairsOfCards){ index in
            return gameTheme.emojiSet[index]
        }
        self.gameTheme = gameTheme
    }
    
        
    static func chooseGameTheme() -> EmojiMemoryGameTheme {
        // TODO: support more themes
        let themes = [
            EmojiMemoryGameTheme(name: "Animals", numberOfPairsOfCards: 4, emojiSet: ["🦒", "🐆", "🐅", "🐘", "🦘", "🦌", "🦧", "🐪", "🦙", "🦍"], color: Color.blue),
            EmojiMemoryGameTheme(name: "Birds", numberOfPairsOfCards: 4, emojiSet: ["🦢", "🐓", "🦆", "🦅", "🦉", "🦃", "🦚", "🦩"], color: Color.yellow),
            EmojiMemoryGameTheme(name: "Halloween", numberOfPairsOfCards: 5, emojiSet: ["👻", "🎃", "👽", "💀", "👺", "🤡", "👿", "🤖", "👹"], color: Color.orange)
        ]
        let chosenGameIndex = Int.random(in: 0..<themes.count)
        return themes[chosenGameIndex]
    }
    
    // MARK: access to model
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: access to game theme
    
    var themeName: String {
        return gameTheme.name
    }
    
    var themeColor: Color {
        return gameTheme.color
    }
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
