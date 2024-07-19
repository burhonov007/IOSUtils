//
//  Extensions.swift
//  IOSUtils
//
//  Created by itserviceimac on 19/07/24.
//

import Foundation
import UIKit
import SwiftUI
import SnapKit


extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        func makeUIViewController(context: Context) -> some UIViewController { viewController }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    }
    
    func showPreview() -> some View { Preview(viewController: self).edgesIgnoringSafeArea(.all) }
}


///


extension UIView {
    private struct Preview: UIViewRepresentable {
        let view: UIView
        func makeUIView(context: Context) -> UIView { view }
        func updateUIView(_ uiView: UIView, context: Context) { }
    }
    
    func showPreview() -> some View { Preview(view: self) }
}


///


extension UIApplication {
    
    class func getTopViewController(base: UIViewController? = UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
            
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
            
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
    
}


extension UINavigationController {
    func push(_ vc: UIViewController, animated: Bool) {
        viewControllers.last?.navigationItem.backButtonTitle = ""
        pushViewController(vc, animated: animated)
    }
}


///


private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        if let t = textField.text {
            textField.text = String(t.prefix(maxLength))
        }
    }
}


///


extension UIImage {
    static func base64ToImg (base64: String) -> UIImage? {
        let imageData = Data(base64Encoded: base64)
        let image = UIImage(data: imageData!)
        return image
    }
    
    static func imageToBase64(img: UIImage) -> String {
        let imageData = img.pngData()!
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }

}

///


extension NSMutableAttributedString {

    func setColor(color: UIColor, forText stringValue: String) {
       let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        self.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        
    }

}


///


extension String {
    var decodeEmoji: String{
        let data = self.data(using: .utf8) ?? Data()
        return String(data: data, encoding: .nonLossyASCII) ?? ""
    }
}


///


extension UIView {
    func addTapGesture(action : @escaping ()->Void ){
        let tap = MyTapGestureRecognizer(target: self , action: #selector(self.handleTap(_:)))
        tap.action = action
        tap.numberOfTapsRequired = 1
        
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
        
    }
    @objc func handleTap(_ sender: MyTapGestureRecognizer) {
        sender.action!()
    }
}
class MyTapGestureRecognizer: UITapGestureRecognizer {
    var action : (()->Void)? = nil
}


///


extension UICollectionView {
    func getCurrentIndex() ->IndexPath? {
        let centerPoint = CGPoint(x: self.contentOffset.x + (self.frame.width / 2), y: (self.frame.height / 2));
        return self.indexPathForItem(at: centerPoint)
    }
}


///



extension UIView {
 
    func dropShadow(color: UIColor = UIColor.black, opacity: Float = 0.5, offSet: CGSize = CGSize(width: 1, height: 1), radius: CGFloat = 1) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
    }
    
}



///


extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexValue = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexValue.hasPrefix("#") {
            hexValue.remove(at: hexValue.startIndex)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexValue).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}



///



extension UIColor {
    static let accentColor = UIColor(named: "AccentColor")
    static let backgroundColor = UIColor(named: "BackgroundColor")
    static let secondary = UIColor(named: "SecondaryBackgroundColor")
}
