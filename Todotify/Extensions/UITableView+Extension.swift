//
//  UITableView+Extension.swift
//  Todotify
//
//  Created by kalmahik on 07.05.2024.

import UIKit

extension UITableView {
    func setEmptyMessage(_ emoji: String, _ title: String) {
        let emptyView = EmptyView(emoji: emoji, title: title)
        self.backgroundView = emptyView
    }

    func restore() {
        self.backgroundView = nil
    }
}
