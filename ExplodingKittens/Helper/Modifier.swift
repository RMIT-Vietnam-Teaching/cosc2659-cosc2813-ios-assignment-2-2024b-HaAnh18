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
            .foregroundColor(.white)
            .fontWeight(.bold)
            .padding(10)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.blue.opacity(0.4))
            }
    }
}
