//
//  Extention.swift
//  htmlParser
//
//  Created by FE Team TV on 9/6/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setDesignField(leftPadding: CGFloat, borderWidth: CGFloat, borderColor: UIColor, bgColor: UIColor) {
        let padding = UIView(frame: CGRectMake(0, 0, 20, leftPadding))
        self.leftView = padding
        self.borderStyle = .RoundedRect
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = 5
        self.leftViewMode = UITextFieldViewMode.Always
        self.backgroundColor = UIColor.grayColor()
        self.autocapitalizationType = UITextAutocapitalizationType.None
    }

}

extension UIFont {
   static func fontFamilySize(fontSize: CGFloat) -> UIFont {
       return UIFont(name: "Arial", size: fontSize)!
    }
}

extension UIColor {
    convenience init(hexString: String) {
        var cString: String = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substringFromIndex(1)
        }
        
        if (cString.characters.count != 6) {
            self.init(white: 0.5, alpha: 1.0)
        } else {
            let rString: String = (cString as NSString).substringToIndex(2)
            let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
            let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
            
            var r: CUnsignedInt = 0, g: CUnsignedInt = 0, b: CUnsignedInt = 0;
            NSScanner(string: rString).scanHexInt(&r)
            NSScanner(string: gString).scanHexInt(&g)
            NSScanner(string: bString).scanHexInt(&b)
            
            self.init(red: CGFloat(r) / CGFloat(255.0), green: CGFloat(g) / CGFloat(255.0), blue: CGFloat(b) / CGFloat(255.0), alpha: CGFloat(1))
        }
    }

   static func textColor() -> UIColor {
        return UIColor.blackColor()
    }

}