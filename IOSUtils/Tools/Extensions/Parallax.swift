//
//  Parallax.swift
//  IOSUtils
//
//  Created by itserviceimac on 19/07/24.
//

import Foundation
import UIKit

extension UIView {
    func addParallax(minRelativeValue: CGFloat, maxRelativeValue: CGFloat) {
        let xMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.x", type: .tiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = minRelativeValue
        xMotion.maximumRelativeValue = maxRelativeValue
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.y", type: .tiltAlongVerticalAxis)
        yMotion.minimumRelativeValue = minRelativeValue
        yMotion.maximumRelativeValue = maxRelativeValue
        
        let motionEffectGroup = UIMotionEffectGroup()
        motionEffectGroup.motionEffects = [xMotion,yMotion]
        
        self.addMotionEffect(motionEffectGroup)
    }
}
