//
//  CalendarCell.swift
//  Todotify
//
//  Created by Murad Azimov on 02.07.2024.
//

import UIKit

final class CalendarCell: UICollectionViewCell {
    
    static let identifier = "CalendarCell"
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    func setupCell(label: String) {
        dateLabel.text = label.split(separator: " ").joined(separator: "\n")
        layer.borderWidth = 2
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 12
        setupViews()
        setupConstraints()
    }
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .red : .yellow
         }
    }
}

extension CalendarCell {
    private func setupViews() {
        setupView(dateLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
