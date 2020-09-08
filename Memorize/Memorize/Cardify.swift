//
//  Cardify.swift
//  Memorize
//
//  Created by Abhas Sinha on 9/7/20.
//  Copyright © 2020 Abhas Sinha. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier  {
    var isFaceUp: Bool
    var gradient: LinearGradient
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3.0).fill(gradient)
                content
            }
            else {
                RoundedRectangle(cornerRadius: 10.0).fill(gradient)
            }
        }
    }
}

extension View {
    func cardify(isFaceUp: Bool, gradient: LinearGradient) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, gradient: gradient))
    }
}
