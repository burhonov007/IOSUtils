//
//  HorizontalGradient.swift
//  IOSUtils
//
//  Created by The WORLD on 17.01.2024.
//

// MARK: Create HORIZONTAL GRADIENT

import UIKit

extension UIView {
   
    func addHGradient(colors: [CGColor?], cornerRadius: CGFloat = 0) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors as [Any]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.cornerRadius = cornerRadius
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
