//
//  DropZoneView.swift
//  ExplodingKittens
//
//  Created by Nana on 21/8/24.
//

import SwiftUI

struct DropZoneView: View {
    @EnvironmentObject var localizationManager: LocalizationManager
    var screenSize: ScreenSizeCategory

    var body: some View {
        Rectangle()
            .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [10, 5]))
            .frame(width: screenSize == .small ? 140 : screenSize == .medium
                   ? 150 : 200, height: screenSize == .small ? 140 : screenSize == .medium
                   ? 150 : 200)
            .overlay(
                Text("Drop Here", manager: localizationManager)
                    .font(Font.custom("Quicksand-Medium", size: 24))
                    .foregroundColor(Color("custom-black"))
            )
    }
}

#Preview {
    PlayCardTutorial()
        .environmentObject(LocalizationManager()) // Inject the LocalizationManager for the preview

}
