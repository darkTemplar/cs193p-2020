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
                Button(action: {
                    withAnimation(.easeInOut) {
                        self.viewModel.resetGame()
                    }
                }, label: {Text("New Game")})
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
                    withAnimation(.linear(duration: 1)) {
                        self.viewModel.choose(card: card)
                    }
                }
                .padding(5)
            }
            .padding()
        }
    }
    
}

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
    
    @State var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            self.content(for: size)
            .cardify(isFaceUp: card.isFaceUp, gradient: gradient)
                .transition(AnyTransition.scale)
        }
    }
    
    private func content(for size: CGSize) -> some View {
        ZStack {
            Group {
                if card.isConsumingBonusTime {
                    Pie(startAngle: Angle(degrees: 0.0 - 90.0), endAngle: Angle(degrees: -360*animatedBonusRemaining - 90.0), clockwise: true)
                        .onAppear{
                            self.startBonusTimeAnimation()
                    }
                } else {
                    Pie(startAngle: Angle(degrees: 0.0 - 90.0), endAngle: Angle(degrees: -360*card.bonusRemaining - 90.0), clockwise: true)
                }
            }.padding(5).foregroundColor(.orange).opacity(0.3)
            
            
            Text(card.content)
                .font(Font.system(size: fontSize(for: size)))
                .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0)).animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}
