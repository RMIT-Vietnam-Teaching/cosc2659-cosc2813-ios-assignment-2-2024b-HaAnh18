//
//  ScreenSize.swift
//  ExplodingKittens
//
//  Created by Nana on 20/8/24.
//

import Foundation
import SwiftUI

enum ScreenSizeCategory {
    case small
    case medium
    case large
    case extraLarge
}

func getScreenSizeCategory(for size: CGSize) -> ScreenSizeCategory {
    let minDimension = min(size.width, size.height)
    
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
