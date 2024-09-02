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

// A custom view modifier that styles a view as a capsule-shaped button.
struct buttonCapsule: ViewModifier {
    
    // This method defines the modifications applied to the content.
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

// A custom view modifier to style a confirm button.
struct confirmButton: ViewModifier {
    
    // This method defines the modifications applied to the content.
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

// A custom view modifier to style a choose button.
struct chooseButton: ViewModifier {
    
    // This method defines the modifications applied to the content.
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color("custom-black"))
            .frame(width: 200)
            .font(Font.custom("Quicksand-Medium", size: 24))
            .padding(10)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("lightblue"), lineWidth: 3.0)
            }
    }
}

// A generic view modifier that can apply any given `ViewModifier` at runtime.
struct AnyViewModifier: ViewModifier {
    
    // Stores the modifier to be applied, as a closure that returns `AnyView`.
    private let modifier: (Content) -> AnyView

    // Initializer that takes any `ViewModifier` and stores it as a type-erased closure.
    init<M: ViewModifier>(_ modifier: M) {
        self.modifier = { content in AnyView(content.modifier(modifier)) }
    }

    // This method applies the stored modifier to the content.
    func body(content: Content) -> some View {
        modifier(content)
    }
}
