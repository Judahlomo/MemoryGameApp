//
//  Card.swift
//  MemoryGameApp
//
//  Created by Judah Lomo on 2/24/25.
//


import SwiftUI

struct Card: Identifiable {
    let id = UUID()  // Unique ID for tracking each card
    let content: String // The emoji displayed on the card
    var isFaceUp: Bool = false // Whether the card is face up
    var isMatched: Bool = false // Whether the card has been matched
}
