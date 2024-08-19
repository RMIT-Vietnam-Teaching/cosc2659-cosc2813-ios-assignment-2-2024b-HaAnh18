//
//  OrientationManager.swift
//  ExplodingKittens
//
//  Created by Nana on 19/8/24.
//

import SwiftUI
import UIKit

class OrientationManager {
    static let shared = OrientationManager()

    func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation: UIInterfaceOrientation) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }

        let geometryPreferences = UIWindowScene.GeometryPreferences.iOS(interfaceOrientations: orientation)
        windowScene.requestGeometryUpdate(geometryPreferences) { error in
            if let error = error as Error?  {
                print("Error changing orientation: \(error.localizedDescription)")
            } else {
                UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")

                if let window = windowScene.windows.first {
                    window.rootViewController?.setNeedsUpdateOfSupportedInterfaceOrientations()
                }
            }
        }
    }
}
