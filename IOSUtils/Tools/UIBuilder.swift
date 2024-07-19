//
//  UIBuilder.swift
//  IOSUtils
//
//  Created by itserviceimac on 19/07/24.
//

import Foundation
import UIKit
import SnapKit


class UIBuilder {
    
    static func label(text: String = "",
                      color: UIColor? = .label,
                      size: CGFloat = 14,
                      minSize: CGFloat? = nil,
                      weight: UIFont.Weight = .regular,
                      lines: Int = 1,
                      alignment: NSTextAlignment = .left ) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        label.textColor = color
        label.numberOfLines = lines
        label.textAlignment = alignment
        
        if let minSize = minSize {
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = minSize / size
        }
        return label
    }
    
    static func textField(
        placeholder: String? = nil,
        textColor: UIColor = .black,
        keyboardType: UIKeyboardType = .default,
        maxLength: Int? = nil,
        cornerRadius: CGFloat? = nil,
        borderColor: CGColor? = nil,
        borderWidth: CGFloat? = nil) -> UITextField {
            
            let field = UITextField()
            field.placeholder = placeholder
            field.keyboardType = keyboardType
            
            field.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            field.textColor = textColor
            field.backgroundColor = UIColor(hex: "F3F4F9")
            field.layer.borderColor = borderColor
            field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 50))
            field.leftViewMode = .always
            if let maxLength = maxLength { field.maxLength = maxLength }
            if let borderWidth = borderWidth { field.layer.borderWidth = borderWidth }
            if let cornerRadius = cornerRadius { field.layer.cornerRadius = cornerRadius }
            field.snp.makeConstraints { $0.height.equalTo(50) }
            return field
        }
    
    
    static func stack(
        arrangedSubviews: [UIView] = [],
        axis: NSLayoutConstraint.Axis = .horizontal,
        spacing: CGFloat = 8,
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill) -> UIStackView {
            let stack = UIStackView(arrangedSubviews: arrangedSubviews)
            stack.axis = axis
            stack.spacing = spacing
            stack.distribution = distribution
            stack.alignment = alignment
            return stack
        }
    
    static func button(title: String,
                       color: UIColor?,
                       textColor: UIColor? = .label,
                       fontSize: CGFloat = 14,
                       weight: UIFont.Weight = .regular,
                       cornerRadius: CGFloat = 10,
                       borderWidth: CGFloat = 0.0,
                       borderColor: CGColor? = nil) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.backgroundColor = color
        button.layer.cornerRadius = cornerRadius
        button.setTitleColor(textColor, for: .normal)
        button.layer.borderWidth = borderWidth
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        if let borderColor = borderColor { button.layer.borderColor = borderColor }
        return button
    }
    
    static func view(color: UIColor, cornerRadius: CGFloat = 0, maskedCorners: CACornerMask? = nil, borderWidth: CGFloat? = nil, borderColor: CGColor? = nil) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.layer.cornerRadius = cornerRadius
        if let borderWidth = borderWidth { view.layer.borderWidth = borderWidth }
        if let borderColor = borderColor { view.layer.borderColor = borderColor }
        if let maskedCorners = maskedCorners { view.layer.maskedCorners = maskedCorners }
        return view
    }
    
    static func buttonWithImage(
        title: String,
        image: UIImage?,
        titleColor: UIColor? = .white,
        backgroundColor: UIColor? = .white,
        cornerRadius: CGFloat = 10,
        font: UIFont = UIFont.systemFont(ofSize: 14, weight: .medium)) -> UIButton {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(titleColor, for: .normal)
            button.backgroundColor = backgroundColor
            button.titleLabel?.font = font
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.contentHorizontalAlignment = .center
            button.layer.cornerRadius = cornerRadius
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            button.setImage(image, for: .normal)
            return button
        }
    
    static func createLine() -> UIView {
        let view = UIView()
        view.backgroundColor = .systemGray3
        view.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        
        return view
    }
}
