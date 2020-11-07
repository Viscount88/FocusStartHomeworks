//
//  MasterViewController.swift
//  Homework_№4
//
//  Created by Андрей Шамин on 11/4/20.
//

import UIKit

final class MasterViewController: UIViewController {

    let masterView = MasterView()
    let detail = DetailViewController()

    override func loadView() {
        masterView.tableViewCellTappedDelegate = self
        view = masterView
        navigationController?.title = "ДЗ 4"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        masterView.chooseFirstCell()
    }
}

extension MasterViewController: TableViewCellTappedDelegate {
    func showNavigationViewController(navigationController: UINavigationController) {
        splitViewController?.showDetailViewController(navigationController, sender: nil)
    }
}
