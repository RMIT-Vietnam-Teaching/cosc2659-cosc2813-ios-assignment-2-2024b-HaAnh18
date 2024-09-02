//
//  Loader.swift
//  ExplodingKittens
//
//  Created by Nana on 22/8/24.
//
/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2024B
  Assessment: Assignment 2
  Author: Nguyen Tran Ha Anh
  ID: s3938490
  Created  date: 06/08/2024
  Last modified: 03/09/2024
  Acknowledgement:
*/

import SwiftUI

struct Loader: View {
    var percent: CGFloat
    var colors: [Color] = [.red, .orange, .yellow, .green, .purple, .red] // The gradient colors for the progress circle.
    var body: some View {
        ZStack {
            Circle()
                .fill(Color("player-row"))
                .frame(width: 60, height: 60)
                .overlay {
                    // Overlay another circle that represents the progress.
                    Circle()
                        .trim(from: 0, to: percent * 0.01) // Draw only a portion of the circle based on `percent`.
                        .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round)) // Customize the stroke with rounded caps and joins.
                        .fill(AngularGradient(gradient: .init(colors: colors), center: .center, startAngle: .zero, endAngle: .init(degrees: 360)))  // Apply a gradient fill to the stroke.
                }
            
            Text("\(String(format: "%.0f", percent)) %")
                .font(.system(size: 16))
                .font(Font.custom("Quicksand-Regular", size: 20))
                .foregroundColor(.black)
        }
    }
}

#Preview {
    Loader(percent: 80)
}
