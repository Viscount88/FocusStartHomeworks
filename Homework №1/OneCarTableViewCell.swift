//
//  OneCarTableViewCell.swift
//  Homework №1
//
//  Created by Андрей Шамин on 10/15/20.
//

import UIKit

class OneCarTableViewCell: UITableViewCell {

    @IBOutlet var manufacturerLabel: UILabel!
    @IBOutlet var modelLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!
    @IBOutlet var yearOfIssueLabel: UILabel!
    @IBOutlet var carNumberLabel: UILabel!

    func setupCell(manufacturerLabelText:String,
                   modelLabelText:String,
                   bodyLabelText:String,
                   yearOfIssueLabelText:Int?,
                   carNumberLabelText:String?) {
        self.manufacturerLabel.text = "Производитель: \(manufacturerLabelText)"
        self.modelLabel.text = "Модель: \(modelLabelText)"
        self.bodyLabel.text = "Тип кузова: \(bodyLabelText)"
        if let yearOfIssueLabelText = yearOfIssueLabelText {
            self.yearOfIssueLabel.text = "Год выпуска: \(yearOfIssueLabelText)"
        } else {
            self.yearOfIssueLabel.text = "Год выпуска: -"
        }
        if let carNumberLabelText = carNumberLabelText {
            self.carNumberLabel.text = "Гос номер: \(carNumberLabelText)"
        } else {
            self.carNumberLabel.text = ""
        }
    }
}
