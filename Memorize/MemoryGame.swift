//
//  MemoryGame.swift
//  Memorize
//
//  Created by Abhas Sinha on 8/11/20.
//  Copyright © 2020 Abhas Sinha. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card) {
        print("Card chosen \(card)")
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for index in 0..<numberOfPairsOfCards{
            cards.append(Card(isFaceUp: true, isMatched: false, id: index*2, content: cardContentFactory(index)))
            cards.append(Card(isFaceUp: true, isMatched: false, id: index*2+1, content: cardContentFactory(index)))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool
        var isMatched: Bool
        var id: Int
        var content: CardContent
        
    }
}
