//
//  TabViewModeGame.swift
//  ExplodingKittens
//
//  Created by Nana on 25/8/24.
//

import SwiftUI

struct TabViewModeGame: View {
    @State var currentTab: Int = 0 // State variable to track the current tab
    @Binding var showingSheet: Bool

    var body: some View {
        ZStack(alignment: .top) {
            TabView(selection: self.$currentTab) {
                ModeGameDescription(modeGame: modeGame[0]).tag(0)
                ModeGameDescription(modeGame: modeGame[1]).tag(1)
                ModeGameDescription(modeGame: modeGame[2]).tag(2)

            }
            .tabViewStyle(.page(indexDisplayMode: .never))

            TabBarView(currentTab: $currentTab)
            
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
            ForEach(Array(zip(self.tabBarOptions.indices, self.tabBarOptions)), id: \.0, content: { index, name in
                TabBarItems(currentTab: self.$currentTab, namespace: namespace.self, tabBarItemName: name, tab: index)
            })
        }
        .frame(height: 80)
        .padding(.horizontal, 15)
    }
}

struct TabBarItems: View {
    @Binding var currentTab: Int
    let namespace: Namespace.ID // Namespace for matched geometry effect
    var tabBarItemName: String
    var tab: Int
    
    var body: some View {
        Button(action: {
            self.currentTab = tab
        }, label: {
            VStack {
                Text(tabBarItemName)

                    .font(Font.custom(currentTab == tab ? "Quicksand-Bold" : "Quicksand-Regular", size: 24))
                    .foregroundColor(currentTab == tab ? Color("red") : .black)

                if currentTab == tab { // If this is the current tab
                    Color(currentTab == tab ? Color("red") : .black)
                        .frame(height: 1)
                        .matchedGeometryEffect(id: "underline", in: namespace, properties: .frame)
                } else {
                    Color.clear
                        .frame(height: 1)
                }
            }
            .animation(.spring(), value: self.currentTab) // Apply spring animation to the current tab change
        })
    }
}

#Preview {
    TabViewModeGame(showingSheet: .constant(true))
}
