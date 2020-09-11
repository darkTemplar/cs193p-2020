//
//  Cardify.swift
//  Memorize
//
//  Created by Abhas Sinha on 9/7/20.
//  Copyright © 2020 Abhas Sinha. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier  {
    var isFaceUp: Bool {
        rotation < 90
    }
    var gradient: LinearGradient
    
    var rotation: Double
    
    init(isFaceUp: Bool, gradient: LinearGradient) {
        self.rotation = isFaceUp ? 0 : 180
        self.gradient = gradient
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(Color.gray, lineWidth: 2.0)
                content
            }
            else {
                RoundedRectangle(cornerRadius: 10.0).fill(gradient)
            }
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
}

extension View {
    func cardify(isFaceUp: Bool, gradient: LinearGradient) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, gradient: gradient))
    }
}
