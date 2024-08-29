//
//  TabViewCardDescription.swift
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
*/

import SwiftUI

struct TabViewCardDescription: View {    
    @State var currentTab: Int = 0 // State variable to track the current tab
    @Binding var showingSheet: Bool
    @Binding var theme: String

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Spacer()
                Button(action: {
                    showingSheet = false
                }, label: {
                    Image(systemName: "x.circle")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color("custom-black"))
                })
            }
            TabView(selection: self.$currentTab) {
                let cardList = theme == "Rabbit" ? cardsV2 : cards
                ForEach(cardList.indices, id: \.self) { index in
                    CardInfo(card: cards[index]).tag(index)
                }
            }
//                .frame(height: 250)
            .tabViewStyle(.page(indexDisplayMode: .never))
        
            HStack(spacing: 10) {
                ForEach(cards.indices, id: \.self) { index in
                    Circle()
                        .fill(currentTab == index ? Color("lightblue") : Color.gray)
                        .frame(width: 10, height: 10)
                }
            }
        }
        .transition(.scale)
        .padding()
    }
}

#Preview {
//    TabViewCardDescription(showingSheet: .constant(true))
    PlayCardTutorial(theme: .constant("Rabbit"))
        .environmentObject(LocalizationManager()) // Inject the LocalizationManager for the preview
}
