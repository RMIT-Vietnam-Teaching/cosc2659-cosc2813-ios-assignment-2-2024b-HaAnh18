//
//  CurvedText.swift
//  ExplodingKittens
//
//  Created by Nana on 31/8/24.
//

import SwiftUI

//extension Animation {
//    static var random: Animation {
//        Animation
//            .linear(duration: 0.5) // Quick linear animation
//            .repeatForever(autoreverses: true) // Repeat indefinitely, reversing each time
//    }
//}

struct RandomScalingView: View {
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        VStack {
            Text("Random Scaling")
                .font(.largeTitle)
                .scaleEffect(scale)
                .onAppear {
                    startRandomScaling()
                }
        }
    }
    
    private func startRandomScaling() {
        withAnimation(.random) {
            scale = CGFloat.random(in: 0.5...1.0) // Random scaling between 0.5x and 1.5x
        }
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            withAnimation(.random) {
                scale = CGFloat.random(in: 0.5...1.0) // Continuously apply random scaling
            }
        }
    }
}


#Preview {
    RandomScalingView()
}
