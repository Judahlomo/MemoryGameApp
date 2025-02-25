//
//  CardGameViewMOdel.swift
//  MemoryGameApp
//
//  Created by Judah Lomo on 2/24/25.
//

import SwiftUI

class CardGameViewModel: ObservableObject {
    @Published var cards: [Card] = []
    @Published var score = 0
    @Published var moves = 0
    @Published var gameOver = false
    
    private var firstSelectedCard: Card?
    
    init() {
        startNewGame()
    }
    
    func startNewGame() {
        let flags = ["🇺🇸", "🇨🇦", "🇩🇪", "🇯🇵", "🇫🇷",  "🇧🇷"]
        let shuffledFlags = (flags + flags).shuffled() // Duplicate & shuffle
        
        cards = shuffledFlags.map { Card(content: $0) }
        
        score = 0
        moves = 0
        gameOver = false
        firstSelectedCard = nil
    }
    
    func flipCard(_ card: Card) {
        guard let index = cards.firstIndex(where: { $0.id == card.id }) else { return }
        
        if cards[index].isMatched || cards[index].isFaceUp {
            return // Ignore already matched or flipped cards
        }
        
        cards[index].isFaceUp.toggle()
        
        if let firstCard = firstSelectedCard {
            moves += 1
            
            if firstCard.content == cards[index].content {
                // Match found
                cards[index].isMatched = true
                if let firstIndex = cards.firstIndex(where: { $0.id == firstCard.id }) {
                    cards[firstIndex].isMatched = true
                }
                score += 2
            } else {
                // No match, flip back after delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    if let firstIndex = self.cards.firstIndex(where: { $0.id == firstCard.id }) {
                        self.cards[firstIndex].isFaceUp = false
                    }
                    self.cards[index].isFaceUp = false
                }
                score = max(0, score - 1) // Prevent negative scores
            }
            
            firstSelectedCard = nil
        } else {
            firstSelectedCard = cards[index]
        }
        
        checkGameOver()
    }
    
    func shuffleCards() {
        withAnimation {
            cards.shuffle()
        }
    }
    
    func checkGameOver() {
        if cards.allSatisfy({ $0.isMatched }) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Small delay for effect
                self.gameOver = true
            }
        }
    }
}
