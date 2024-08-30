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
    
    @State private var open: Bool = false

    var color: String
    var content: String
    var image: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                withAnimation {
                    open.toggle()
                }
            }, label: {
                Image(systemName: image)
                    .foregroundColor(.black)
                    .font(.system(size: 20))
            })

            if open {
                Text(localizationManager.localizedString(for: content))
                    .font(Font.custom("Quicksand-Bold", size: 10))
                    .padding(5)
                    .background {
                        Capsule()
                            .foregroundColor(Color(color))
                    }
                    .offset(y: 5)
    //                .opacity(open ? 1 : 0)
                    .animation(.easeInOut(duration: 0.3), value: open) // Apply animation to the transition
    //                .frame(width: 100)
            }
        }
//        .frame(width: 20)
        
    }
}

#Preview {
    Badge(color: "lightblue", content: "Win 5 Games", image: "moon.stars.circle.fill")
        .environmentObject(LocalizationManager()) // Inject the LocalizationManager for the preview
}
