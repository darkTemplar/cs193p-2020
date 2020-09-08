//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Abhas Sinha on 8/7/20.
//  Copyright © 2020 Abhas Sinha. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        VStack {
            HStack {
                Button("New Game", action: viewModel.resetGame)
                    .foregroundColor(Color.white)
                    .padding(10)
                    .background(Color.green)
                    .cornerRadius(8.0)
                Spacer()
                Text(viewModel.themeName).font(.headline)
                Spacer()
                Text("Score: \(viewModel.score)")
            }.padding()
            
            Grid (items: viewModel.cards){ card in
                CardView(card: card, gradient: LinearGradient(gradient: Gradient(colors: self.viewModel.themeColors), startPoint: .topLeading, endPoint: .bottomTrailing)).onTapGesture {
                    self.viewModel.choose(card: card)
                }
                .padding(5)
            }
            .padding()
        }
    }
    
}

/**
 
 */

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let model = EmojiMemoryGame()
        model.choose(card: model.cards[2])
        return EmojiMemoryGameView(viewModel: model)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var gradient: LinearGradient
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            self.content(for: size)
            .cardify(isFaceUp: card.isFaceUp, gradient: gradient)
        }
    }
    
    private func content(for size: CGSize) -> some View {
        ZStack {
            Pie(startAngle: Angle(degrees: 0.0 - 90.0), endAngle: Angle(degrees: 110.0 - 90.0), clockwise: true).padding(5).foregroundColor(.orange).opacity(0.3)
            Text(card.content).font(Font.system(size: fontSize(for: size)))
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}
