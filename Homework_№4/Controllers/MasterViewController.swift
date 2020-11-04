//
//  MasterViewController.swift
//  Homework_№4
//
//  Created by Андрей Шамин on 11/4/20.
//

import UIKit

class MasterViewController: UITableViewController {

    // MARK: - Constants

    private enum Constants {
        static let tableViewCellIdentifier = "cell-id"
        static let errorMessage = "Произошла ошибка"
        static let tableViewEstimatedHeight:CGFloat = 44
    }

    // MARK: - Properties

    var headingArray = ["Заголовок1",
                        "Заголовок2\nЗаголовок2",
                        "Заголовок3",
                        "Заголовок4",
                        "Заголовок5"]

    var textArray = ["Текст1",
                     "Текст2",
                     "Больше текста, и времени нет и еще чуток",
                     "Много текста, но с временем\nМного текста, но с временем",
                     ""]

    var timeArray = ["16:27",
                     "16:28",
                     "",
                     "16:30",
                     ""]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Просто для красоты =)
        if #available(iOS 13, *) {
            self.tableView = UITableView(frame: .zero, style: .insetGrouped)
        }
        self.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: Constants.tableViewCellIdentifier)
        self.navigationItem.title = "ДЗ 4"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        chooseFirstCell()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
            chooseFirstCell()
    }
}

// MARK: - Метод нажатия на TableViewCell и метод для показа первой Cell на больших устройствах в DetailVC при запуске

private extension MasterViewController {
    func chooseFirstCell() {
        if DeviceTraitStatus.current == .wRhR || DeviceTraitStatus.current == .wRhC{
            choseCellAt(indexPath: IndexPath(row: 0, section: 0))
        }
    }

    func choseCellAt(indexPath:IndexPath) {
        guard let customTableViewCell = self.tableView.cellForRow(at: indexPath) as? CustomTableViewCell else {
            return
        }

        let detailViewController = DetailViewController()
        detailViewController.navigationTitle = customTableViewCell.headingLabel.text ?? Constants.errorMessage
        detailViewController.titleText = customTableViewCell.myTextLabel.text ?? Constants.errorMessage
        detailViewController.chosenIndexPath = indexPath

        let navigationController = UINavigationController(rootViewController: detailViewController)
        self.splitViewController?.showDetailViewController(navigationController, sender: nil)
    }
}

// MARK: - UITableViewDelegate

extension MasterViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        choseCellAt(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.tableViewEstimatedHeight
    }
}

// MARK: - UITableViewDataSource

extension MasterViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headingArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellIdentifier, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        cell.setupCell(heading: headingArray[indexPath.row], text: textArray[indexPath.row], time: timeArray[indexPath.row])
        return cell
    }
}

