//
//  UserDef.swift
//  IOSUtils
//
//  Created by The WORLD on 17.01.2024.
//

// MARK: To SAVE and UPLOAD the application theme and JSON to UserDefaults

import UIKit
import SwiftyJSON

class UserDef {
    
    static func saveThemeToUDef(theme: Theme) {
        UserDefaults.standard.set(theme.rawValue, forKey: Keys.theme.rawValue)
    }
    
    static func loadThemeFromUDef() -> String {
        if let theme = UserDefaults.standard.string(forKey: Keys.theme.rawValue) {
            return theme
        } else {
            return "system"
        }
    }
    
    static func saveItemsToUDef(_ updatedPosition: JSON) {
        if let jsonData = try? updatedPosition.rawData() {
            UserDefaults.standard.set(jsonData, forKey: Keys.items.rawValue)
        }
    }
    
    static func loadItemsFromUDef() -> JSON {
        if let items = UserDefaults.standard.data(forKey: Keys.items.rawValue),
           let items = try? JSON(data: items) {
            return items
        } else {
            return JSON.null
        }
    }
    
    enum Keys: String {
        case theme = "theme"
        case items = "items"
    }
    
    enum Theme: String {
        case dark = "dark"
        case light = "light"
        case system = "system"
    }
}

