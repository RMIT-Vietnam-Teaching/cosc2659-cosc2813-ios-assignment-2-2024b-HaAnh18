//
//  ContentView.swift
//  ExplodingKittens
//
//  Created by Nana on 11/8/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        LandscapeViewControllerRepresentable()
        GameView(numberOfPlayers: 2)
//        Test(numberOfPlayers: 2)
//        MenuView()
//        Text("\(AppDelegate.orientationLock)")
    }
}

#Preview {
    ContentView()
}
