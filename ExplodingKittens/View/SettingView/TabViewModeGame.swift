//
//  TabViewModeGame.swift
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

struct TabViewModeGame: View {
    @State var currentTab: Int = 0 // State variable to track the current tab
    @Binding var showingSheet: Bool

    var body: some View {
        ZStack(alignment: .top) {
            // A TabView that allows the user to swipe between different game mode descriptions.
            TabView(selection: self.$currentTab) {
                // Each ModeGameDescription view is tagged with a unique index.
                ModeGameDescription(modeGame: modeGame[0]).tag(0)
                ModeGameDescription(modeGame: modeGame[1]).tag(1)
                ModeGameDescription(modeGame: modeGame[2]).tag(2)

            }
            .tabViewStyle(.page(indexDisplayMode: .never)) // Style the TabView as a page view with hidden index indicators.

            TabBarView(currentTab: $currentTab)
            
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
            .padding(10)
        }
    }
}

struct TabBarView: View {
    @Binding var currentTab: Int
    @Namespace var namespace // Namespace for matched geometry effect
    
    var tabBarOptions: [String] = ["Easy", "Medium", "Hard"]
    
    var body: some View {
        HStack(spacing: 5) {
            // Loop through each tab option, associating it with its index
            ForEach(Array(zip(self.tabBarOptions.indices, self.tabBarOptions)), id: \.0, content: { index, name in
                TabBarItems(currentTab: self.$currentTab, namespace: namespace.self, tabBarItemName: name, tab: index)
            })
        }
        .frame(height: 80)
        .padding(.horizontal, 15)
    }
}

struct TabBarItems: View {
    @EnvironmentObject var localizationManager: LocalizationManager

    @Binding var currentTab: Int
    let namespace: Namespace.ID // Namespace for matched geometry effect
    var tabBarItemName: String
    var tab: Int
    
    var body: some View {
        Button(action: {
            // When the button is tapped, set the current tab to this tab's index
            self.currentTab = tab
        }, label: {
            VStack {
                // Display the tab name, localized and styled based on whether it's the current tab
                Text(localizationManager.localizedString(for: tabBarItemName))
                    .font(Font.custom(currentTab == tab ? "Quicksand-Bold" : "Quicksand-Regular", size: 24))
                    .foregroundColor(currentTab == tab ? Color("red") : Color("custom-black"))

                if currentTab == tab { // If this is the current tab
                    // Show a colored underline with a matched geometry effect
                    Color(currentTab == tab ? Color("red") : Color("custom-black"))
                        .frame(height: 1)
                        .matchedGeometryEffect(id: "underline", in: namespace, properties: .frame)
                } else {
                    // Otherwise, show a clear (invisible) underline to maintain spacing
                    Color.clear
                        .frame(height: 1)
                }
            }
            .animation(.spring(), value: self.currentTab) // Apply spring animation to the current tab change
        })
    }
}

#Preview {
//    TabViewModeGame(showingSheet: .constant(true))
    MenuView()
}
