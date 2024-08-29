//
//  Badge.swift
//  ExplodingKittens
//
//  Created by Nana on 25/8/24.
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

struct Badge: View {
    @EnvironmentObject var localizationManager: LocalizationManager

    var color: String
    var content: String
    
    var body: some View {
        Text(localizationManager.localizedString(for: content))
            .font(Font.custom("Quicksand-Bold", size: 10))
            .padding(5)
            .background {
                Capsule()
                    .foregroundColor(Color(color))
            }
    }
}

#Preview {
    Badge(color: "lightblue", content: "Win 5 Games")
        .environmentObject(LocalizationManager()) // Inject the LocalizationManager for the preview
}
