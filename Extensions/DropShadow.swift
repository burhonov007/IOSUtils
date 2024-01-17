//
//  DropShadow.swift
//  IOSUtils
//
//  Created by The WORLD on 17.01.2024.
//

// MARK: Create SHADOW around UIVIEW

import UIKit

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.cyan.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .zero
        layer.shadowRadius = 30
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
