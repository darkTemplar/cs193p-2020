//
//  MemoryGame.swift
//  Memorize
//
//  Created by Abhas Sinha on 8/11/20.
//  Copyright © 2020 Abhas Sinha. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0
    private var onlyFaceUpCardIndex: Int? {
        get {
            let faceUpIndices: [Int] = cards.indices.filter {cards[$0].isFaceUp}
            return faceUpIndices.count == 1 ? faceUpIndices.first : nil
        }
        set {
            for index in cards.indices {
                    cards[index].isFaceUp = index == newValue
                }
            }
        }
    
    
    mutating func choose(card: Card) {
        print("Card chosen \(card)")
        if let chosenIndex = indexOf(card: card), !self.cards[chosenIndex].isFaceUp, !self.cards[chosenIndex].isMatched {
            if let potentialMatchIndex = self.onlyFaceUpCardIndex {
                if (self.cards[chosenIndex].content == self.cards[potentialMatchIndex].content){
                    score += 2
                    self.cards[potentialMatchIndex].isMatched = true
                    self.cards[chosenIndex].isMatched = true
                } else {
                    // in case of a mismatch deduct -1 if card already seen
                    // however only set already seen prop when evaluating a mismatch and this only needs to happen after the card has been evaluated for a match
                        score += self.cards[chosenIndex].alreadySeen ? -1 : 0
                        score += self.cards[potentialMatchIndex].alreadySeen ? -1 : 0
                        self.cards[chosenIndex].alreadySeen = true
                    self.cards[potentialMatchIndex].alreadySeen = true
                    }
                } else {
                // single cards will go through this flow
                onlyFaceUpCardIndex = chosenIndex
            }
            self.cards[chosenIndex].isFaceUp = true
        }
    }
    
    func indexOf(card: Card) -> Int? {
        self.cards.firstIndex(where: {$0.id == card.id})
    }
    
    func indexOfMatch(for card: Card) -> Int? {
        self.cards.firstIndex(where: {$0.isFaceUp && $0.content == card.content})
    }
    
    func indexOfFirstUnmatched() -> Int? {
        self.cards.firstIndex(where: {$0.isFaceUp && !$0.isMatched})
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for index in 0..<numberOfPairsOfCards{
            cards.append(Card(isFaceUp: false, isMatched: false, alreadySeen: false, id: index*2, content: cardContentFactory(index)))
            cards.append(Card(isFaceUp: false, isMatched: false, alreadySeen: false, id: index*2+1, content: cardContentFactory(index)))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool
        var isMatched: Bool
        var alreadySeen: Bool
        var id: Int
        var content: CardContent
        
    }
}
