//
//  UIView+Extension.swift
//  Todotify
//
//  Created by Murad Azimov on 01.07.2024.
//

import UIKit

extension UIView {
    func setupView(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
//        subview.layer.borderWidth = 1
        addSubview(subview)
    }
}
