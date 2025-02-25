//
//  CardView.swift
//  MemoryGameApp
//
//  Created by Judah Lomo on 2/24/25.
//

import SwiftUI

struct CardView: View {
    @ObservedObject var viewModel: CardGameViewModel
    let card: Card

    @State private var rotation: Double = 0 // Tracks rotation for flipping

    var body: some View {
        ZStack {
            if card.isFaceUp {
                CardFront
            } else {
                CardBack
            }
        }
        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0)) // 3D flip effect
        .onTapGesture {
            flipCard()
        }
    }

    var CardFront: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
            .overlay(
                Text(card.content)
                    .font(.largeTitle)
            )
            .frame(width: 80, height: 120) // Adjust card size
            .opacity(card.isFaceUp ? 1 : 0)
    }

    var CardBack: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue, Color.indigo]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: 2) // Adds a border
            )
            .shadow(radius: 4) // Soft shadow for depth
            .frame(width: 80, height: 120) // Adjust card size
    }


    private func flipCard() {
        guard !card.isMatched else { return } // Ignore matched cards

        withAnimation(.easeInOut(duration: 0.5)) {
            rotation += 180 // Rotate 180 degrees
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            viewModel.flipCard(card)
        }
    }
}
