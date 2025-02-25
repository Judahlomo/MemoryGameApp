//
//  ContentView.swift
//  MemoryGameApp
//
//  Created by Judah Lomo on 2/24/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CardGameViewModel()

    var body: some View {
        VStack {
            Text("Memory Game")
                .font(.largeTitle)
                .padding()
            
            ScoreboardView(viewModel: viewModel)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
                ForEach(viewModel.cards) { card in
                    CardView(viewModel: viewModel, card: card)
                }
            }

            HStack {
                Button("New Game") {
                    withAnimation {
                        viewModel.startNewGame()
                    }
                }
                .buttonStyle(.bordered)

                Button("Shuffle") {
                    withAnimation {
                        viewModel.shuffleCards()
                    }
                }
                .buttonStyle(.bordered)
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
