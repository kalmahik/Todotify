//
//  String+Extension.swift
//  Todotify
//
//  Created by Murad Azimov on 04.07.2024.
//

import Foundation
import UIKit

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 0, length: attributeString.length)
        )
        return attributeString
    }
}
