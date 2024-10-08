//
//  DropDownView.swift
//  ExplodingKittens
//
//  Created by Nana on 23/8/24.
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
 https://www.youtube.com/watch?v=7NSOcE3EvOs&t=494s
*/

import SwiftUI

struct DropDownView: View {
    @State private var isExpanded = false
    @EnvironmentObject var localizationManager: LocalizationManager

    @Binding var selection: String
    var options: [String]
    
    var body: some View {
        VStack {
            if !isExpanded {
                HStack {
                    Text(localizationManager.localizedString(for: selection))
                        .font(Font.custom("Quicksand-Regular", size: 20))
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .rotationEffect(.degrees(isExpanded ? -180 : 0))
                        
                    
                }
                // Adds a tap gesture to the view that toggles the `isExpanded` state with an animation.
                .onTapGesture {
                    // Perform the toggle action with an animation.
                    withAnimation(.easeInOut) {
                        isExpanded.toggle()
                    }
                }
                .frame(height: 40)
                .padding(.horizontal, 10)
            }
            
            
            if isExpanded {
                VStack {
                    ForEach(options, id: \.self) { option in
                        HStack {
                            Text(localizationManager.localizedString(for: option))
                                .foregroundStyle(selection == option ? Color("custom-black") : .gray)
                                .font(Font.custom("Quicksand-Regular", size: 20))
                            
                            Spacer()
                        }
                        .frame(height: 40)
                        .padding(.horizontal)
                        .onTapGesture {
                            // When an option is tapped, animate the toggle of `isExpanded` and update the selection.
                            withAnimation(.snappy) {
                                isExpanded.toggle()
                                selection = option
                            }
                        }
                    }
                }
            }
            
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("custom-black"), lineWidth: 1)
        )
        .frame(width: 200)
        .onChange(of: localizationManager.currentLanguage, initial: true) { _, _ in
            // Re-render view when language changes
            selection = selection // Re-trigger the binding
        }
    }
}

#Preview {
//    DropDownView(selection: .constant("Option 1"), options: ["Option 1", "Option 2", "Option 3"])
    MenuView()
}
