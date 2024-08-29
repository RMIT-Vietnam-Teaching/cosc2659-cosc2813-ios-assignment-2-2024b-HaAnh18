//
//  TableView.swift
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

struct TableView: View {
    var cardGame: [String: [Int]]?
    var orderedKeys: [String]
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            VStack(spacing: 10) {
                TableHeader(size: size.width / 4)
                
                VStack {
                    if cardGame != nil {
                        ForEach(orderedKeys, id: \.self) { key in
                            if cardGame![key]![0] != 0 {
                                HStack {
                                    TableRow(name: key, size: size.width / 4, cardGame: cardGame)
                                }
                            }
                        }
                    }
                }
            }
        }
        .frame(height: 240)
    }
}

struct TableHeader: View {
    @EnvironmentObject var localizationManager: LocalizationManager

    var size: CGFloat
    var body: some View {
        HStack {
            Spacer()
            
            Text("2 players", manager: localizationManager)
                .font(Font.custom("Quicksand-Medium", size: 20))
                .fontWeight(.semibold)
                .frame(width: size)
            
            Text("3 players", manager: localizationManager)
                .font(Font.custom("Quicksand-Medium", size: 20))
                .fontWeight(.semibold)
                .frame(width: size)
            
            Text("4 players", manager: localizationManager)
                .font(Font.custom("Quicksand-Medium", size: 20))
                .fontWeight(.semibold)
                .frame(width: size)
            
        }
        .padding(.vertical, 10)
        .overlay(
            Rectangle()
                .frame(height: 1) // Thickness of the border
                .foregroundColor(Color("custom-black")),
            alignment: .bottom
        )
    }
}

struct TableRow: View {
    @EnvironmentObject var localizationManager: LocalizationManager

    var name: String
    var size: CGFloat
    var cardGame: [String: [Int]]?
    
    var body: some View {
        HStack {
            Text(localizationManager.localizedString(for: name))
                .font(Font.custom("Quicksand-Regular", size: 20))
                .fontWeight(.semibold)
                .frame(width: size)

            Text(localizationManager.localizedString(for: "\(String(describing: cardGame![name]![0]))"))
                .font(Font.custom("Quicksand-Regular", size: 20))
                .frame(width: size)
            
            Text("\(String(describing: cardGame![name]![1]))")
                .font(Font.custom("Quicksand-Regular", size: 20))
                .frame(width: size)
            
            Text("\(String(describing: cardGame![name]![2]))")
                .font(Font.custom("Quicksand-Regular", size: 20))
                .frame(width: size)
        }
    }
}


#Preview {
//    TableView()
    MenuView()
//    ModeGameDescription(modeGame: modeGame[0])
}
