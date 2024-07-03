//
//  TodoCell.swift
//  Todotify
//
//  Created by Murad Azimov on 01.07.2024.
//

import UIKit

final class TodoCell: UITableViewCell {
    static let identifier = "TodoCell"
        
    private lazy var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var dot: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()

    func setupCell(text: String, isCompleted: Bool, color: UIColor) {
        title.text = text
        dot.backgroundColor = color
        setupViews()
        setupConstraints()
    }
}

extension TodoCell {
    private func setupViews() {
        setupView(title)
        setupView(dot)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: dot.leadingAnchor, constant: -8),
            
            dot.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 8),
            dot.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            dot.heightAnchor.constraint(equalToConstant: 8),
            dot.widthAnchor.constraint(equalToConstant: 8),
            dot.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
