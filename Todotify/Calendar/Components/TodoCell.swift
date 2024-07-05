//
//  TodoCell.swift
//  Todotify
//
//  Created by Murad Azimov on 01.07.2024.
//

import UIKit

final class TodoCell: UITableViewCell {
    static let identifier = "TodoCell"
        
    lazy var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var dot: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 2
        return view
    }()

    func setupCell(text: String, isCompleted: Bool, color: UIColor) {
        let attributes: [NSAttributedString.Key: Any] = isCompleted ? 
        [ .strikethroughStyle: NSUnderlineStyle.single.rawValue, .foregroundColor: UIColor.gray] :
        [ .foregroundColor: UIColor.label ]
               
        title.attributedText = NSAttributedString(string: text, attributes: attributes)
        
//        title.text = text
        title.textColor = isCompleted ? .gray : .label
        dot.backgroundColor = .red
        setupViews()
        setupConstraints()
    }
}

// MARK: - Configure

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
            dot.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dot.heightAnchor.constraint(equalToConstant: 12),
            dot.widthAnchor.constraint(equalToConstant: 12),
            dot.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
