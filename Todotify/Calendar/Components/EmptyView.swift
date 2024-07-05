//
//  EmptyTrackersView.swift
//  Habitify
//
//  Created by Murad Azimov on 06.04.2024.
//

import UIKit

final class EmptyView: UIView {

    init(emoji: String, title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func commonInit() {
        setupSubviews()
        setupConstraints()
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 2
        return label
    }()

    private func setupSubviews() {
        setupView(titleLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
