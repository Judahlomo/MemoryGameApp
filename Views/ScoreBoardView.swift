//
//  ScoreBoardView.swift
//  MemoryGameApp
//
//  Created by Judah Lomo on 2/24/25.
//


import SwiftUI

struct ScoreboardView: View {
    @ObservedObject var viewModel: CardGameViewModel

    var body: some View {
        VStack {
            HStack {
                Text("Score: \(viewModel.score)")
                    .font(.headline)
                    .padding()
                
                Spacer()
                
                Text("Moves: \(viewModel.moves)")
                    .font(.headline)
                    .padding()
            }
            .background(Color.white.opacity(0.2))
            .cornerRadius(10)
            .padding()

            // Display "Game Over!" when all cards are matched
            if viewModel.gameOver {
                Text("🎉 Game Over! 🎉")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                    .padding()
                    .transition(.scale) // Adds animation effect
            }
        }
    }
}

