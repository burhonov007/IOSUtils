//
//  UICreator.swift
//  IOSUtils
//
//  Created by The WORLD on 17.01.2024.
//

// MARK: Class for create LABEL, BUTTON with ARROW, HStack and VStack

import UIKit
import SwiftUI

class UICreator {
    
    static func labelCreator(weight: UIFont.Weight? = .light, size: CGFloat = 16, min: CGFloat = 10, text: String? = "", textColor: UIColor = .label) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: size, weight: weight!)
        label.minimumScaleFactor = min / size
        label.adjustsFontSizeToFitWidth = true
        label.textColor = textColor
        return label
    }

    static func arrowBtnCreator(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor(named: "btnTitleColor"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
        button.contentHorizontalAlignment = .left
        let rightArrow = UIImageView(image: UIImage(named: "right_arrow"))
        button.addSubview(rightArrow)
        
        rightArrow.snp.makeConstraints{ make in
            make.top.bottom.equalToSuperview().inset(2)
            make.trailing.equalToSuperview()
        }
        
        button.snp.makeConstraints { $0.height.equalTo(20) }
        return button
    }
    
    static func vStackCreator(subviews: [UIView], spacing: CGFloat = 10, distribution: UIStackView.Distribution = .fill ) -> UIStackView {
        let stack: UIStackView = UIStackView(arrangedSubviews: subviews)
        stack.axis = .vertical
        stack.spacing = spacing
        stack.distribution = distribution
        return stack
    }
    
    static func hStackCreator(subviews: [UIStackView], spacing: CGFloat = 10, distribution: UIStackView.Distribution = .fillEqually ) -> UIStackView {
        let stack: UIStackView = UIStackView(arrangedSubviews: subviews)
        stack.axis = .horizontal
        stack.spacing = spacing
        stack.distribution = distribution
        return stack
    }
    
    static func hStackCreator(subviews: [UIView], spacing: CGFloat = 10, distribution: UIStackView.Distribution = .fillEqually ) -> UIStackView {
        let stack: UIStackView = UIStackView(arrangedSubviews: subviews)
        stack.axis = .horizontal
        stack.spacing = spacing
        stack.distribution = distribution
        return stack
    }
}
