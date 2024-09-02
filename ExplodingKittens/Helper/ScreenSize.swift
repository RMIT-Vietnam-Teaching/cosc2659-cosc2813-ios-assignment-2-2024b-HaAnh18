//
//  ScreenSize.swift
//  ExplodingKittens
//
//  Created by Nana on 20/8/24.
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

// Enum to represent different screen size categories.
enum ScreenSizeCategory {
    case small
    case medium
    case large
    case extraLarge
}

// Function to determine the screen size category based on the minimum dimension (width or height) of the screen.
func getScreenSizeCategory(for size: CGSize) -> ScreenSizeCategory {
    // Calculate the minimum dimension (either width or height) of the screen size.
    let minDimension = min(size.width, size.height)
    
    // Determine the screen size category based on the minimum dimension.
    switch minDimension {
    case 0..<375:
        return .small
    case 375..<768:
        return .medium
    case 768..<1024:
        return .large
    default:
        return .extraLarge
    }
}
