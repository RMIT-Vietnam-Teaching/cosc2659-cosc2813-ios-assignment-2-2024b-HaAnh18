//
//  Testing.swift
//  ExplodingKittens
//
//  Created by Nana on 21/8/24.
//

import SwiftUI

import SwiftUI

struct DraggableCardView: View {
    @State private var offset = CGSize.zero
    @State private var startPosition = CGSize.zero
    
    var body: some View {
        VStack {
            cards[0].frontImage
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .padding(-14)
                .foregroundColor(.white)
                .offset(x: offset.width, y: offset.height)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            self.offset = CGSize(
                                width: gesture.translation.width + self.startPosition.width,
                                height: gesture.translation.height + self.startPosition.height
                            )
                        }
                        .onEnded { _ in
                            self.startPosition = self.offset
                        }
                )
        }
    }
}



#Preview {
    DraggableCardView()
}
