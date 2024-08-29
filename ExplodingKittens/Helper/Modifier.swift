//
//  Modifier.swift
//  ExplodingKitten
//
//  Created by Nana on 11/8/24.
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

import Foundation
import SwiftUI

struct buttonCapsule: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color("custom-black"))
            .frame(width: 200)
            .font(Font.custom("Quicksand-Medium", size: 24))
            .padding(10)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color("lightblue"))
            }
    }
}

struct confirmButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .font(Font.custom("Quicksand-Medium", size: 24))
            .padding(10)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color("red"))
            }
    }
}
