//
//  UILabel+Extension.swift
//  Todotify
//
//  Created by Murad Azimov on 04.07.2024.
//

import UIKit

extension UILabel {

func strikeThrough(_ isStrikeThrough: Bool) {
    
    if isStrikeThrough {
        if let labelText = self.text {
            let attributeString =  NSMutableAttributedString(string: labelText)
            attributeString.addAttribute(
                NSAttributedString.Key.strikethroughStyle,
                value: NSUnderlineStyle.single.rawValue,
                range: NSMakeRange(0, attributeString.length)
            )
            self.attributedText = attributeString
        }
    } else {
        if let attributedStringText = self.attributedText {
            let txt = attributedStringText.string
            self.attributedText = nil
            self.text = txt
            return
        }
    }
    }
}
