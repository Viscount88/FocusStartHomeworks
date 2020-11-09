//
//  ViewController.swift
//  Homework №1
//
//  Created by Андрей Шамин on 10/15/20.
//

import UIKit

class CarListViewController: UIViewController {

    private enum Constants {
        static let tableViewCellID = "OneCarTableViewCell"
        static let addCarSegueID = "AddCarSegueID"
        static let filterCarBodySegueID = "FilterCarBodySegueID"
        static let filterViewCornerRadius:CGFloat = 25
    }

    @IBOutlet var filterView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var filterLabel: UILabel!
    @IBOutlet var disableFilterButton: UIButton!

    var carsArray:[Car] = []
    var filteredCarsArray:[Car] = []
    var isFilterActive:Bool = false

    fileprivate func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.carsArray.append(Car(manufacturer: "Mazda", model: "model", body: .cabrio, yearOfIssue: nil, carNumber: "321"))
        self.disableFilterButton.isHidden = true
        self.filterView.layer.cornerRadius = Constants.filterViewCornerRadius
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.addCarSegueID {
            (segue.destination as! AddingNewCarViewController).saveCarDelegate  = self
        }
        if segue.identifier == Constants.filterCarBodySegueID {
            (segue.destination as! CarBodysTableViewController).chosenCarBodyDelegate = self
        }
    }

    @IBAction func disableFilterAction(_ sender: Any) {
        self.isFilterActive = false
        self.filteredCarsArray = []
        self.tableView.reloadData()
        self.filterLabel.text = "Нет активных фильтров"
        self.disableFilterButton.isHidden = true
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension CarListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isFilterActive {
            return self.filteredCarsArray.count
        } else {
            return self.carsArray.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellID) as! OneCarTableViewCell

        if self.isFilterActive {
            if !self.filteredCarsArray.isEmpty{
                let car = self.filteredCarsArray[indexPath.row]
                cell.setupCell(manufacturerLabelText: car.manufacturer,
                               modelLabelText: car.model,
                               bodyLabelText: car.body.rawValue,
                               yearOfIssueLabelText: car.yearOfIssue,
                               carNumberLabelText: car.carNumber)
            }
        } else {
            let car = self.carsArray[indexPath.row]
            cell.setupCell(manufacturerLabelText: car.manufacturer,
                           modelLabelText: car.model,
                           bodyLabelText: car.body.rawValue,
                           yearOfIssueLabelText: car.yearOfIssue,
                           carNumberLabelText: car.carNumber)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - SaveCarDelegate
extension CarListViewController: SaveCarDelegate {
    func saveCar(_ car: Car){
        self.carsArray.append(car)
        self.tableView.reloadData()
    }
}

// MARK: - ChosenCarBodyDelegate
extension CarListViewController: ChosenCarBodyDelegate {
    func chosenBody(body: String) {
        self.isFilterActive = true
        self.filteredCarsArray = self.carsArray.filter { $0.body.rawValue == body }
        self.tableView.reloadData()
        self.disableFilterButton.isHidden = false
        self.filterLabel.text = "Активный фильтр по кузову:\n\(body)"
    }
}
