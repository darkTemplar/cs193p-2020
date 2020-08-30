//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Abhas Sinha on 8/11/20.
//  Copyright © 2020 Abhas Sinha. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var gameTheme: EmojiMemoryGameTheme
    @Published private var model: MemoryGame<String>
        
    
    init() {
        (self.gameTheme, self.model) = EmojiMemoryGame.newGame()
    }
    
    static func newGame() -> (theme: EmojiMemoryGameTheme, model: MemoryGame<String>) {
        var gameTheme = EmojiMemoryGame.chooseGameTheme()
        // shuffle emojis to get a diff. bunch each time
        gameTheme.emojiSet.shuffle()
        let model = MemoryGame<String>(numberOfPairsOfCards: gameTheme.numberOfPairsOfCards){ index in
            return gameTheme.emojiSet[index]
        }
        return (gameTheme, model)
    }
        
    static func chooseGameTheme() -> EmojiMemoryGameTheme {
        let themes = [
            EmojiMemoryGameTheme(name: "Animals", numberOfPairsOfCards: 6, emojiSet: ["🦒", "🐆", "🐅", "🐘", "🦘", "🦌", "🦧", "🐪", "🦙", "🦍"], color: [Color.blue, Color.white, Color.pink]),
            EmojiMemoryGameTheme(name: "Birds", numberOfPairsOfCards: 6, emojiSet: ["🦢", "🐓", "🦆", "🦅", "🦉", "🦃", "🦚", "🦩"], color: [Color.blue, Color.white, Color.black]),
            EmojiMemoryGameTheme(name: "Halloween", numberOfPairsOfCards: 6, emojiSet: ["👻", "🎃", "👽", "💀", "👺", "🧝‍♀️", "🧟‍♂️", "🧛🏻‍♂️", "🧞‍♀️"], color: [Color.orange, Color.orange]),
            EmojiMemoryGameTheme(name: "Clothes", numberOfPairsOfCards: 6, emojiSet: ["👔", "🩳", "👗", "🥼", "🧥", "👘", "🥻", "👖", "🦺"], color: [Color.red, Color.orange, Color.yellow]),
            EmojiMemoryGameTheme(name: "Food", numberOfPairsOfCards: 6, emojiSet: ["🌮", "🍗", "🍣", "🥠", "🍰", "🍤", "🥪", "🥮", "🍕"], color: [Color.green, Color.yellow]),
            EmojiMemoryGameTheme(name: "Sports", numberOfPairsOfCards: 6, emojiSet: ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🎱", "🏸", "🥍"], color: [Color.white, Color.pink, Color.red])
        ]
        let chosenGameIndex = Int.random(in: 0..<themes.count)
        return themes[chosenGameIndex]
    }
    
    // MARK: access to model
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    // MARK: access to game theme
    
    var themeName: String {
        return gameTheme.name
    }
    
    var themeColors: Array<Color> {
        return gameTheme.color
    }
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func resetGame() {
        (self.gameTheme, self.model) = EmojiMemoryGame.newGame()
    }
}
