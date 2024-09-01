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

class LocalizationManager: ObservableObject {
    @Published var currentLanguage: String = Locale.current.language.languageCode?.identifier ?? "en"
    
    func localizedString(for key: String) -> String {
        guard let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return NSLocalizedString(key, comment: "")
        }
        return NSLocalizedString(key, bundle: bundle, comment: "")
    }
    
    func changeLanguage(to language: String) {
        currentLanguage = language
        UserDefaults.standard.set([language], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
}

extension LocalizedStringKey {
    var key: String {
        let mirror = Mirror(reflecting: self)
        let attributeLabel = mirror.children.first { $0.label == "key" }
        return attributeLabel?.value as? String ?? ""
    }
}

extension Text {
    init(_ key: LocalizedStringKey, manager: LocalizationManager) {
        let localizedString = manager.localizedString(for: key.key)
        self.init(localizedString)
    }
}

extension String {
    func localized(in language: String) -> String {
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return self // Return the original string if localization fails
        }
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
