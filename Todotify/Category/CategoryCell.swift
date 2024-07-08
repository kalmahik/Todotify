//
//  CategoryCell.swift
//  Todotify
//
//  Created by kalmahik on 07.05.2024.

import UIKit

final class CategoryCell: UITableViewCell {

    // MARK: - Constants

    static let identifier = "CategoryCell"

    // MARK: - Private Properties

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private lazy var checkImage: UIImageView = UIImageView(image: UIImage(systemName: "checkmark"))

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        checkImage.isHidden = !selected
    }

    // MARK: - Public Methods

    func setupCell(category: Category) {
        titleLabel.text = category.name
        clipsToBounds = true
        layer.cornerRadius = 16
    }
}

extension CategoryCell {
    private func setupViews() {
        setupView(titleLabel)
        setupView(checkImage)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: checkImage.leadingAnchor),

            checkImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            checkImage.widthAnchor.constraint(equalToConstant: 24),
            checkImage.heightAnchor.constraint(equalToConstant: 24),
            checkImage.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
