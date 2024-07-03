//
//  CalendarViewController.swift
//  Todotify
//
//  Created by Murad Azimov on 01.07.2024.
//

import UIKit

class CalendarViewController: UIViewController {
    var sections: [(String, [TodoItem])] = []
    
    private var calendarView: HorizontalCalendar
    
    init(sections: [(String, [TodoItem])]) {
        self.calendarView = HorizontalCalendar(days: sections.map { $0.0 })
        super.init(nibName: nil, bundle: nil)
        self.sections = sections
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        calendarView.delegate = self
        setupViews()
        setupConstraints()
    }
    
    func syncTableView(section: Int) {
        tableView.scrollToRow(at: IndexPath(item: 0, section: section), at: .top, animated: true)
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
        let item = sections[indexPath.section].1[indexPath.row]
        trackerCell.setupCell(text: item.text, isCompleted: false, color: .red)
        return trackerCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].0
    }
}

extension CalendarViewController: UITableViewDelegate {
    
}

extension CalendarViewController: HorizontalCalendarDelegate {
    func didSelectItem(at index: Int) {
        tableView.scrollToRow(at: IndexPath(item: 0, section: index), at: .top, animated: false)
    }
}

extension CalendarViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleSections = tableView.indexPathsForVisibleRows?.map { $0.section } ?? []
        if let firstVisibleSection = visibleSections.first {
            calendarView.scrollToItem(at: firstVisibleSection)
        }
    }
}

extension CalendarViewController {
    private func setupViews() {
        view.setupView(calendarView)
        view.setupView(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            calendarView.heightAnchor.constraint(equalToConstant: 100),
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        
        ])
    }
}
