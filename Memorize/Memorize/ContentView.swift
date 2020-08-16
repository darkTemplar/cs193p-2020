//
//  ContentView.swift
//  Memorize
//
//  Created by Abhas Sinha on 8/7/20.
//  Copyright © 2020 Abhas Sinha. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame
    var body: some View {
        HStack {
            ForEach(viewModel.cards){ card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
            }
        }
            .padding()
            .foregroundColor(Color.orange)
            .font(viewModel.cards.count < 5 ? Font.largeTitle : Font.title)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        return ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3.0)
                Text(card.content)
            }
            else {
                RoundedRectangle(cornerRadius: 10.0)
            }
            
        }
        .aspectRatio(0.667, contentMode: .fit)
    }
}
