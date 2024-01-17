//
//  ClearBackBtnInNavController.swift
//  IOSUtils
//
//  Created by The WORLD on 17.01.2024.
//

// MARK: Сlears the button text and makes the button white in the navigation bar

import UIKit

extension UINavigationController {
    func clearBackButtonTitle() {
        self.viewControllers.last?.navigationItem.backButtonTitle = ""
        self.viewControllers.last?.navigationController?.navigationBar.tintColor = .white
    }
}
