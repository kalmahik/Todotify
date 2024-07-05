//
//  CategoriesViewController.swift
//  Todotify
//
//  Created by kalmahik on 07.05.2024.

import UIKit

final class CategoriesViewController: UIViewController {

    // MARK: - Constants

    static let reloadCollection = Notification.Name(rawValue: "reloadCollection")

    // MARK: - Private Properties

    private var viewModel: CategoryViewModel
    private var categories: [Category] = []
    private var observer: NSObjectProtocol?

    private lazy var addCategoryButton = CustomButton(
        title: NSLocalizedString("categoryCreationButton", comment: ""),
        color: .black,
        style: .normal
    ) {
        let categoryCreationVC = UINavigationController(rootViewController: CategoryCreationViewController(viewModel: self.viewModel))
        self.present(categoryCreationVC, animated: true)
    }

    private lazy var doneButton = CustomButton(
        title: NSLocalizedString("doneButton", comment: ""),
        color: .black,
        style: .normal
    ) {
        self.dismiss(animated: true)
    }

    private lazy var tableView: UITableView = {
        let tableView  = UITableView(frame: self.view.frame, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.scrollIndicatorInsets = tableView.contentInset
        tableView.layer.cornerRadius = 16
        tableView.layer.masksToBounds = true
        return tableView
    }()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        addObserver()
    }

    init(for viewModel: CategoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bind()
        viewModel.loadCategories()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bind() {
        viewModel.isEmptyStateBinding = { [weak self] isEmpty in
            isEmpty ?
            self?.tableView.setEmptyMessage("💫", NSLocalizedString("categoriesEmpty", comment: "")) :
            self?.tableView.restore()
        }

        viewModel.categoriesBinding = { [weak self] categories in
            self?.categories = categories
        }
    }

    private func addObserver() {
        observer = NotificationCenter.default.addObserver(
            forName: CategoriesViewController.reloadCollection,
            object: nil,
            queue: .main
        ) {
            [weak self] _ in self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate

extension CategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath: indexPath)
    }
}

// MARK: - UITableViewDataSource

extension CategoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath)
        guard let categoryCell = cell as? CategoryCell else { return UITableViewCell() }
        let category = categories[indexPath.row]
        categoryCell.setupCell(category: category)
        return categoryCell
    }
}

// MARK: - applyConstraints && addSubViews

extension CategoriesViewController {
    // MARK: - Configure

    private func setupView() {
        view.backgroundColor = .white
        navigationItem.title = NSLocalizedString("categoryTitle", comment: "")
        view.setupView(tableView)
        view.setupView(addCategoryButton)
        view.setupView(doneButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: addCategoryButton.topAnchor, constant: -24),

            addCategoryButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            addCategoryButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addCategoryButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addCategoryButton.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -16),

            doneButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            doneButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}
