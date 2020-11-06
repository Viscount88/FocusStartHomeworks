//
//  MasterView.swift
//  Homework_№4
//
//  Created by Андрей Шамин on 11/6/20.
//

import UIKit

final class MasterView: UIView {

    // MARK: - Constants

    private enum Constants {
        static let errorMessage = "Произошла ошибка"
    }

    // MARK: - Views

    let tableView: UITableView = {
        var tableView = UITableView()
        return tableView
    }()

    // MARK: - Properties

    private var tableViewDataSource = CustomTableViewDataSource()
    private var tableViewDelegate: CustomTableViewDelegate?
    var tableViewCellTappedDelegate: TableViewCellTappedDelegate?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
        setupDelegates()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func chooseFirstCell() {
        if DeviceTraitStatus.current == .wRhR || DeviceTraitStatus.current == .wRhC{
            selectedCell(indexPath: IndexPath(row: 0, section: 0))
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        chooseFirstCell()
    }
}

// MARK: - Установка констреинтов

private extension MasterView {
    
    func setupElements(forIndexPath indexPath: IndexPath = IndexPath(row: 0, section: 0)) {
        self.backgroundColor = .systemBackground
        self.addSubview(tableView)
        setupTableViewConstraints()
        registerTableViewCell()
    }

    func setupTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }

    func registerTableViewCell() {
        self.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.reuseIdentifier)
    }
}

// MARK: - DataSource и Delegate для tableView

private extension MasterView {
    func setupDelegates() {
        tableViewDelegate = CustomTableViewDelegate(withDelegate: self)
        tableViewDataSource.dataArray = DataModel.getDataModel()
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate
    }
}

// MARK: - MasterViewControllerDelegate - Обработка тапа на ячейку

extension MasterView: MasterViewControllerDelegate{
    func selectedCell(indexPath: IndexPath) {

        let object = tableViewDataSource.dataArray[indexPath.row]
        let detailViewController = DetailViewController()

        detailViewController.navigationTitle = object.heading
        detailViewController.titleText = object.text
        detailViewController.chosenIndexPath = indexPath
        tableView.deselectRow(at: indexPath, animated: true)

        let navigationController = UINavigationController(rootViewController: detailViewController)
        tableViewCellTappedDelegate?.showNavigationViewController(navigationController: navigationController)
    }
}
