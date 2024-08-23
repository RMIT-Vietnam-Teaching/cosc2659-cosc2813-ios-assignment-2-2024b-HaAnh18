//
//  TabViewCardDescription.swift
//  ExplodingKittens
//
//  Created by Nana on 23/8/24.
//

import SwiftUI

struct TabViewCardDescription: View {
    @State var currentTab: Int = 0 // State variable to track the current tab
    @Binding var showingSheet: Bool

    var body: some View {
//        ZStack {
            VStack(spacing: 10) {
                HStack {
                    Spacer()
                    Button(action: {
                        showingSheet = false
                    }, label: {
                        Image(systemName: "x.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.black)
                    })
                }
                TabView(selection: self.$currentTab) {
                    ForEach(cards.indices, id: \.self) { index in
                        CardInfo(card: cards[index]).tag(index)
                    }
                }
//                .frame(height: 250)
                .tabViewStyle(.page(indexDisplayMode: .never))
            
                HStack(spacing: 10) {
                    ForEach(cards.indices, id: \.self) { index in
                        Circle()
                            .fill(currentTab == index ? Color.blue : Color.gray)
                            .frame(width: 10, height: 10)
                    }
                }
            }
//        }
        .transition(.scale)
        .padding()
//        .frame(height: 200)

    }
}

#Preview {
//    TabViewCardDescription(showingSheet: .constant(true))
    PlayCardTutorial()
}
