//
//  CustomButton.swift
//  Todotify
//
//  Created by kalmahik on 07.05.2024.

import UIKit

enum ButtonStyle {
    case normal
    case flat
}

enum ButtonState {
    case normal
    case disabled
}

final class CustomButton: UIButton {
    var action: () -> Void

    var color: UIColor = .black {
        didSet {
            backgroundColor = color
        }
    }

    var disabledColor: UIColor = .gray

    var height: CGFloat

    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                backgroundColor = color
            } else {
                backgroundColor = disabledColor
                layer.borderColor = UIColor.gray.cgColor
            }
        }
    }

    var style: ButtonStyle = .normal

    init(
        title: String,
        color: UIColor,
        style: ButtonStyle,
        height: CGFloat = 60,
        action: @escaping () -> Void = {}
    ) {
        self.action = action
        self.color = color
        self.style = style
        self.height = height
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        backgroundColor = color
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func didTapButton() {
        action()
    }

    private func setupViews() {
        backgroundColor = style == .flat ? .white : color
        setTitleColor(style == .flat ? color : .white, for: .normal)
        addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = isEnabled ? color.cgColor : UIColor.gray.cgColor
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: height)
        ])
    }
}
