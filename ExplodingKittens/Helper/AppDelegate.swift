//
//  AppDelegate.swift
//  ExplodingKitten
//
//  Created by Nana on 11/8/24.
//

import Foundation
import SwiftUI

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var orientationLock = UIInterfaceOrientationMask.landscapeRight

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}
 
