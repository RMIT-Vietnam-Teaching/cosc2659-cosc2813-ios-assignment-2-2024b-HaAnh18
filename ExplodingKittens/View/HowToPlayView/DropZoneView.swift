//
//  DropZoneView.swift
//  ExplodingKittens
//
//  Created by Nana on 21/8/24.
//

import SwiftUI

struct DropZoneView: View {
    let size: CGSize
    let areAnyCardsInDropZone: Bool

    var body: some View {
        Rectangle()
            .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [10, 5]))
            .frame(width: size.width, height: size.height)
            .overlay(
                Text(areAnyCardsInDropZone ? "Dropped!" : "Drop Here")
                    .foregroundColor(.black)
            )
    }
}

#Preview {
    PlayCardTutorial()
}
