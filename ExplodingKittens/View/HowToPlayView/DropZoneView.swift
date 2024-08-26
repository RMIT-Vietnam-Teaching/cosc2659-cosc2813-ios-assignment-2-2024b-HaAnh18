//
//  DropZoneView.swift
//  ExplodingKittens
//
//  Created by Nana on 21/8/24.
//

import SwiftUI

struct DropZoneView: View {
    @EnvironmentObject var localizationManager: LocalizationManager

    @State private var size: CGFloat = 10
    
    var screenSize: ScreenSizeCategory

    var body: some View {
        Rectangle()
            .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [10, 5]))
            .frame(width: size, height: size)
            .overlay(
                Text("Drop Here", manager: localizationManager)
                    .font(Font.custom("Quicksand-Medium", size: 24))
                    .foregroundColor(.black)
            )
            .onAppear {
                setComponentSize()
            }
    }
    
    func setComponentSize() {
        switch screenSize {
        case .small:
            size = 140
        case .medium:
            size = 150
        case .large:
            size = 200
        case .extraLarge:
            size = 120
        }
    }
}

#Preview {
    PlayCardTutorial()
        .environmentObject(LocalizationManager()) // Inject the LocalizationManager for the preview

}
