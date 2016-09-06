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