//
//  CarBodysTableViewController.swift
//  Homework №1
//
//  Created by Андрей Шамин on 10/15/20.
//

import UIKit

class CarBodysTableViewController: UITableViewController {

    fileprivate enum Constants {
        static let tableViewCellID = "CarBodysTableVIewCellID"
    }

    var chosenCarBodyDelegate:ChosenCarBodyDelegate?
    var carBodyTypes:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        for bodyTypeCase in Body.allCases {
            carBodyTypes.append(bodyTypeCase.rawValue)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carBodyTypes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellID)
        cell?.textLabel?.text = carBodyTypes[indexPath.row]
        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let chosenCarBodyDelegate = chosenCarBodyDelegate{
            chosenCarBodyDelegate.chosenBody(body: carBodyTypes[indexPath.row])
        }
        navigationController?.popViewController(animated: true)
    }
}
