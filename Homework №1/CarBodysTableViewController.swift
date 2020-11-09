//
//  CarBodysTableViewController.swift
//  Homework №1
//
//  Created by Андрей Шамин on 10/15/20.
//

import UIKit

class CarBodysTableViewController: UITableViewController {

    private enum Constants {
        static let tableViewCellID = "CarBodysTableVIewCellID"
    }

    var chosenCarBodyDelegate:ChosenCarBodyDelegate?
    var carBodyTypes:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        for bodyTypeCase in Body.allCases {
            self.carBodyTypes.append(bodyTypeCase.rawValue)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.carBodyTypes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellID) else {
            fatalError("Can't dequeue cell with reuse identifier \(Constants.tableViewCellID)")
        }
        cell.textLabel?.text = self.carBodyTypes[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let chosenCarBodyDelegate = self.chosenCarBodyDelegate{
            chosenCarBodyDelegate.chosenBody(body: self.carBodyTypes[indexPath.row])
        }
        navigationController?.popViewController(animated: true)
    }
}
