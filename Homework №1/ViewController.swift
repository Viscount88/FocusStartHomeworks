//
//  ViewController.swift
//  Homework №1
//
//  Created by Андрей Шамин on 10/15/20.
//

import UIKit

class ViewController: UIViewController {

    fileprivate enum Constants {
        static let tableViewCellID = "OneCarTableViewCell"
        static let addCarSegueID = "addCarSegueID"
        static let filterCarBodySegueID = "filterCarBodySegueID"
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
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        carsArray.append(Car(manufacturer: "Mazda", model: "model", body: .cabrio, yearOfIssue: nil, carNumber: "321"))
        disableFilterButton.isHidden = true
        filterView.layer.cornerRadius = Constants.filterViewCornerRadius
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
        isFilterActive = false
        self.filteredCarsArray = []
        self.tableView.reloadData()
        filterLabel.text = "Нет активных фильтров"
        disableFilterButton.isHidden = true
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFilterActive {
            return filteredCarsArray.count
        } else {
            return carsArray.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellID) as! OneCarTableViewCell

        if isFilterActive {
            if !filteredCarsArray.isEmpty{
                let car = filteredCarsArray[indexPath.row]
                cell.setupCell(manufacturerLabelText: car.manufacturer,
                               modelLabelText: car.model,
                               bodyLabelText: car.body.rawValue,
                               yearOfIssueLabelText: car.yearOfIssue,
                               carNumberLabelText: car.carNumber)
            }
        } else {
            let car = carsArray[indexPath.row]
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
extension ViewController: SaveCarDelegate {
    func saveCar(_ car: Car){
        carsArray.append(car)
        self.tableView.reloadData()
    }
}

// MARK: - ChosenCarBodyDelegate
extension ViewController: ChosenCarBodyDelegate {
    func chosenBody(body: String) {
        isFilterActive = true
        self.filteredCarsArray = self.carsArray.filter { $0.body.rawValue == body }
        self.tableView.reloadData()
        disableFilterButton.isHidden = false
        filterLabel.text = "Активный фильтр по кузову:\n\(body)"
    }
}
