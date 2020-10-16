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
        manufacturerLabel.text = "Производитель: \(manufacturerLabelText)"
        modelLabel.text = "Модель: \(modelLabelText)"
        bodyLabel.text = "Тип кузова: \(bodyLabelText)"
        if let yearOfIssueLabelText = yearOfIssueLabelText {
            yearOfIssueLabel.text = "Год выпуска: \(yearOfIssueLabelText)"
        } else {
            yearOfIssueLabel.text = "Год выпуска: -"
        }
        if let carNumberLabelText = carNumberLabelText {
            carNumberLabel.text = "Гос номер: \(carNumberLabelText)"
        } else {
            carNumberLabel.text = ""
        }
    }
}
