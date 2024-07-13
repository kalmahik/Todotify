//
//  HorizontalCalendar.swift
//  Todotify
//
//  Created by Murad Azimov on 02.07.2024.
//

import UIKit

protocol CalendarCellDelegate: AnyObject {
    func didSelectItem(at index: Int)
}

class HorizontalCalendar: UIView {

    weak var delegate: CalendarCellDelegate?

    var days: [String] = []

    init(days: [String]) {
        self.days = days
        super.init(frame: .zero)
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        var collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: CalendarCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = false
        return collectionView
    }()

    func updateData(days: [String]) {
        self.days = days
        collectionView.reloadData()
    }

    private func setupCollectionView() {
        setupViews()
        setupConstraints()
    }
}

// MARK: - UICollectionViewDataSource

extension HorizontalCalendar: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        days.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCell.identifier, for: indexPath) as? CalendarCell else {
            return UICollectionViewCell()
        }
        cell.setupCell(label: days[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HorizontalCalendar: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize { CGSize(width: 72, height: 72) }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets { UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16) }

}

// MARK: - UICollectionViewDelegate

extension HorizontalCalendar: UICollectionViewDelegate {

    // manually select cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(at: indexPath.item)
    }

    // select cell automatically
    func scrollToItem(at index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        self.collectionView.selectItem(
            at: indexPath,
            animated: true,
            scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally
        )
    }
}

// MARK: - Configure

extension HorizontalCalendar {
    private func setupViews() {
        backgroundColor = .gray
        setupView(collectionView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 1),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1)
        ])
    }
}
