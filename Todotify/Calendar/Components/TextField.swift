//
//  TextField.swift
//  Todotify
//
//  Created by kalmahik on 07.05.2024.

import UIKit

class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 30)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
         let originalRect = super.clearButtonRect(forBounds: bounds)
         return originalRect.offsetBy(dx: -4, dy: 0)
    }
}
