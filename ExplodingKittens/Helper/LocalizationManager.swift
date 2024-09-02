//
//  LanguageManager.swift
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

import Foundation
import SwiftUI

// This class handles localization by managing the current language setting and providing localized strings.
class LocalizationManager: ObservableObject {
    
    // The current language of the app, published to notify views when it changes.
    @Published var currentLanguage: String = Locale.current.language.languageCode?.identifier ?? "en"
    
    // This function retrieves the localized string for a given key.
    // - Parameters:
    //   - key: The key for the localized string.
    // - Returns: The localized string for the current language, or the default localization if not found.
    func localizedString(for key: String) -> String {
        // Try to find the path for the language-specific bundle.
        guard let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            // If the bundle or path is not found, return the default localization.
            return NSLocalizedString(key, comment: "")
        }
        // Return the localized string from the specific bundle.
        return NSLocalizedString(key, bundle: bundle, comment: "")
    }
    
    // This function changes the current language of the app.
    // - Parameters:
    //   - language: The new language code to switch to.
    func changeLanguage(to language: String) {
        // Update the current language.
        currentLanguage = language
        // Save the selected language to UserDefaults so it persists across app launches.
        UserDefaults.standard.set([language], forKey: "AppleLanguages")
        // Synchronize UserDefaults to ensure the changes are saved.
        UserDefaults.standard.synchronize()
    }
}

// This extension adds a computed property `key` to `LocalizedStringKey`.
// It allows you to extract the underlying key from a `LocalizedStringKey` instance.
extension LocalizedStringKey {
    
    // Computed property to retrieve the key used in the `LocalizedStringKey`.
    var key: String {
        // Use reflection to inspect the properties of `LocalizedStringKey`.
        let mirror = Mirror(reflecting: self)
        
        // Find the child whose label is "key". This corresponds to the underlying key in the `LocalizedStringKey`.
        let attributeLabel = mirror.children.first { $0.label == "key" }
        
        // Return the value of the "key" attribute as a `String`. If it doesn't exist, return an empty string.
        return attributeLabel?.value as? String ?? ""
    }
}

// Extension for the `Text` view in SwiftUI to support custom localization.
extension Text {
    
    // Custom initializer that takes a `LocalizedStringKey` and a `LocalizationManager`.
    init(_ key: LocalizedStringKey, manager: LocalizationManager) {
        // Retrieve the localized string using the `LocalizationManager`.
        let localizedString = manager.localizedString(for: key.key)
        // Initialize the `Text` view with the localized string.
        self.init(localizedString)
    }
}

// Extension for `String` to provide a method for localizing the string in a specified language.
extension String {
    
    // Method to return the localized version of the string in the specified language.
    func localized(in language: String) -> String {
        // Find the path for the language-specific bundle.
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return self // Return the original string if localization fails
        }
        // Return the localized string using the found bundle.
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
