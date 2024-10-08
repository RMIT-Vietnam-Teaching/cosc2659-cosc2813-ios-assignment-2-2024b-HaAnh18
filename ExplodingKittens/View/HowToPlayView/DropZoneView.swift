//
//  DropZoneView.swift
//  ExplodingKittens
//
//  Created by Nana on 21/8/24.
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

struct DropZoneView: View {
    @EnvironmentObject var localizationManager: LocalizationManager
    var screenSize: ScreenSizeCategory

    var body: some View {
        Rectangle()
            .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [10, 5]))
            .frame(width: screenSize == .small ? 150 : screenSize == .medium ? 160 : 220, height: screenSize == .small ? 150 : screenSize == .medium ? 160 : 220)
            .overlay(
                Text("Drop Your Card Here", manager: localizationManager)
                    .font(Font.custom("Quicksand-Medium", size: 20))
                    .foregroundColor(Color("custom-black"))
                    .frame(width: screenSize == .small ? 140 : screenSize == .medium ? 150 : 210)
                    .multilineTextAlignment(.center)
            )
    }
}

#Preview {
    PlayCardTutorial(theme: .constant("Rabbit"))
        .environmentObject(LocalizationManager()) // Inject the LocalizationManager for the preview

}
