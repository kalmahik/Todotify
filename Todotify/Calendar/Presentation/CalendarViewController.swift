//
//  CalendarViewController.swift
//  Todotify
//
//  Created by Murad Azimov on 01.07.2024.
//

import UIKit
import SwiftUI

// MARK: - UIViewController

final class CalendarViewController: UIViewController {
    private var store: Store
    private var viewModel: CalendarViewModel
    private var sections: TodosGrouped = []
    
    init(for viewModel: CalendarViewModel, store: Store) {
        self.viewModel = viewModel
        self.store = store
        super.init(nibName: nil, bundle: nil)
        bind()
        viewModel.loadTodos()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var calendarView: HorizontalCalendar!
    
    private lazy var tableView: UITableView = {
        let tableView  = UITableView(frame: self.view.frame, style: .insetGrouped)
        tableView.register(TodoCell.self, forCellReuseIdentifier: TodoCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.separatorStyle = .singleLine
        tableView.contentInset.bottom = 500
        return tableView
    }()
    
    private lazy var plusButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "custom.plus.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 4
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.delegate = self
        setupViews()
        setupConstraints()
        
    }
    
    private func bind() {
        viewModel.todosBinding = { [weak self] sections in
            guard let self else { return }
            self.sections = sections
            if self.calendarView == nil {
                self.calendarView = HorizontalCalendar(days: sections.map { $0.0 })
            }
        }
    }
    
    @objc private func didTapPlusButton() {
        let model = TodoDetailModel(store: store)
        let viewModel = TodoDetailViewModel(todoDetailModel: model, todoItem: nil)
        let swiftUIView = TodoDetail(viewModel:viewModel)
        let hostingController = UIHostingController(rootView: swiftUIView)
        navigationController?.present(hostingController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension CalendarViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.identifier, for: indexPath)
        guard let trackerCell = cell as? TodoCell else { return UITableViewCell() }
        let todoItem = sections[indexPath.section].1[indexPath.row]
        trackerCell.setupCell(text: todoItem.text, isCompleted: todoItem.isCompleted, color: UIColor(hex: todoItem.hexColor) ?? .clear)
        return trackerCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].0
    }
}

// MARK: - UITableViewDelegate

extension CalendarViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todoItem = sections[indexPath.section].1[indexPath.row]
        let model = TodoDetailModel(store: store)
        let viewModel = TodoDetailViewModel(todoDetailModel: model, todoItem: todoItem)
        let swiftUIView = TodoDetail(viewModel:viewModel)
        let hostingController = UIHostingController(rootView: swiftUIView)
        navigationController?.present(hostingController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension CalendarViewController: CalendarCellDelegate {
    // select day in a calendar
    func didSelectItem(at index: Int) {
        tableView.scrollToRow(at: IndexPath(item: 0, section: index), at: .top, animated: true)
    }
}

// MARK: - UIScrollViewDelegate

extension CalendarViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.isTracking || scrollView.isDragging || scrollView.isDecelerating) { // игнорим скролл из кода
            if let topSection = tableView.indexPathsForVisibleRows?.first {
                calendarView.scrollToItem(at: topSection.section)
            }
        }
    }
}

// MARK: - UISwipeActionsConfiguration

extension CalendarViewController {
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Complete") { (action, view, completionHandler) in
            let todo = self.sections[indexPath.section].1[indexPath.row]
            self.viewModel.setCompleted(todo: todo, isCompleted: true)
            completionHandler(true)
        }
        action.backgroundColor = UIColor(Color.green)
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Incomplete") { (action, view, completionHandler) in
            let todo = self.sections[indexPath.section].1[indexPath.row]
            self.viewModel.setCompleted(todo: todo, isCompleted: false)
            completionHandler(true)
        }
        action.backgroundColor = UIColor(Color.green)
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}

// MARK: - Configure

extension CalendarViewController {
    private func setupViews() {
        view.setupView(calendarView)
        view.setupView(tableView)
        view.setupView(plusButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            calendarView.heightAnchor.constraint(equalToConstant: 100),
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: calendarView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            plusButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            plusButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
}
