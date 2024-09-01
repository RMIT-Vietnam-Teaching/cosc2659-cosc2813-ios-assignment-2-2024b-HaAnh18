//
//  BombPercent.swift
//  ExplodingKittens
//
//  Created by Nana on 31/8/24.
//

import SwiftUI

extension Animation {
    static var random: Animation {
        Animation
            .linear(duration: 0.5) // Quick linear animation
            .repeatForever(autoreverses: true) // Repeat indefinitely, reversing each time
    }
}

struct BombPercent: View {
    @State private var scale: CGFloat = 1.0
    @Binding var percent: CGFloat
    var colors: [Color] = [.yellow, .orange, .red, .purple, .green, .yellow]
    // purple -> green, red -> yellow,
    var body: some View {
        ZStack {
            Circle()
                .fill(.white)
                .frame(width: 70, height: 70)
                .overlay {
                    Circle()
                        .trim(from: 0, to: percent * 0.01)
                        .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                        .fill(AngularGradient(
                            gradient: .init(colors: colors),
                            center: .center,
                            startAngle: .init(degrees: -270),  // Start angle at -270 degrees
                            endAngle: .init(degrees: 90)))  // End angle adjusted accordingly
                        .rotationEffect(.degrees(-270))
                    
                }
                .animation(.spring(response: 1.0, dampingFraction: 1.0, blendDuration: 1.0), value: percent)
            
            Text("\(String(format: "%.0f", percent)) %")
                .font(Font.custom("Quicksand-Bold", size: 20))
            
            Image("bomb-percent")
                .resizable()
                .frame(width: 100, height: 100)
                .offset(y: -7)
        }
        .scaleEffect(scale)
//        .onAppear {
//            startRandomScaling()
//        }
        .onChange(of: percent, initial: true) {
            if percent >= 80 {
                startRandomScaling()
            }
        }
    }
    
    private func startRandomScaling() {
        withAnimation(.random) {
            scale = CGFloat.random(in: 0.8...1.2) // Random scaling between 0.8x and 1.5x
        }
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            withAnimation(.random) {
                scale = CGFloat.random(in: 0.8...1.2) // Continuously apply random scaling
            }
        }
    }
}

#Preview {
    BombPercent(percent: .constant(50))
}


