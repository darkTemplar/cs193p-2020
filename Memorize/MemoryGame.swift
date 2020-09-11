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
    private(set) var numberOfPairsOfActiveCards: Int
    
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
                    let bonus = Int(5*(self.cards[chosenIndex].bonusRemaining + self.cards[potentialMatchIndex].bonusRemaining))
                    score += 5 + bonus
                    self.cards[potentialMatchIndex].isMatched = true
                    self.cards[chosenIndex].isMatched = true
                    // decrement active pairs of cards
                    self.numberOfPairsOfActiveCards -= 1
                } else {
                    // in case of a mismatch deduct -5 if card already seen
                    // however only set already seen prop when evaluating a mismatch and this only needs to happen after the card has been evaluated for a match
                    score += self.cards[chosenIndex].alreadySeen ? -5 : 0
                    score += self.cards[potentialMatchIndex].alreadySeen ? -5 : 0
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
        numberOfPairsOfActiveCards = numberOfPairsOfCards
        cards = Array<Card>()
        for index in 0..<numberOfPairsOfCards{
            cards.append(Card(isMatched: false, alreadySeen: false, id: index*2, content: cardContentFactory(index)))
            cards.append(Card(isMatched: false, alreadySeen: false, id: index*2+1, content: cardContentFactory(index)))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool {
            didSet {
                stopUsingBonusTime()
            }
        }
        var alreadySeen: Bool
        var id: Int
        var content: CardContent
        
        
        // MARK: - Bonus Time
        
        // this potentially gives matching bonus points
        // if card is matched before a certain time limit while card is face up
        
        // can be 0 meaning no bonus available for this card
        var bonusTimeLimit: TimeInterval = 5
        
        // last time when card was turned face up (and is still face up)
        var lastFaceUpdate: Date?
        
        // how long card has been face up in the past (not including current face up time)
        var pastFaceUpTime: TimeInterval = 0
        
        var faceUpTime: TimeInterval {
            if let lastFaceUpdate = self.lastFaceUpdate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpdate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
      
        var bonusRemaining: Double {
            (bonusTimeRemaining > 0 && bonusTimeLimit > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // called when card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpdate == nil {
                lastFaceUpdate = Date()
            }
        }
        
        // called when card goes face down (or gets matchedP)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpdate = nil
        }
        
    }
}
