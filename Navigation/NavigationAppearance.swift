//
//  Appearance.swift
//  IOSUtils
//
//  Created by The WORLD on 17.01.2024.
//

// MARK: Setup UINavigationBarAppearance and makes it transparent

import UIKit

extension CustomNavController {
    
    private func setupNavBarAppearance() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .clear
        navBarAppearance.shadowColor = .clear
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.standardAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationBar.compactAppearance = navBarAppearance
    }
    
}
