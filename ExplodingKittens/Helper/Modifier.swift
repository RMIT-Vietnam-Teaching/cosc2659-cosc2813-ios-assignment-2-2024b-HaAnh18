//
//  Modifier.swift
//  ExplodingKitten
//
//  Created by Nana on 11/8/24.
//

import Foundation
import SwiftUI

struct buttonCapsule: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .frame(width: 200)
            .font(Font.custom("Quicksand-Medium", size: 24))
            .padding(10)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color("lightblue"))
            }
    }
}

struct confirmButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .font(Font.custom("Quicksand-Medium", size: 24))
            .padding(10)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color("red"))
            }
    }
}
