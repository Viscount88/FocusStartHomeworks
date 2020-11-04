//
//  CustomTableViewCell.swift
//  Homework_№4
//
//  Created by Андрей Шамин on 11/4/20.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    // MARK: - Fonts

    private enum Fonts {
        static let textFont = UIFont.italicSystemFont(ofSize: 16)
        static let headingFont = UIFont.systemFont(ofSize: 22, weight: .bold)
    }

    // MARK: - Constants

    private enum Constants {
        static let notEmptyTimeLabelWidth:CGFloat = 60
        static let headingLeadingAnchor:CGFloat = 16
        static let anchorConstant:CGFloat = 8
        static let labelsNumberOfLines = 0
    }

    // MARK: - Properties

    let headingLabel = UILabel()
    let myTextLabel = UILabel()
    let timeLabel = UILabel()

    var timeLabelWidth:NSLayoutConstraint?

    // MARK: - Метод для конфигурации TableViewCell извне

    func setupCell(heading:String, text:String, time:String) {
        self.headingLabel.text = heading
        self.myTextLabel.text = text
        self.timeLabel.text = time
        if time.isEmpty {
            timeLabelWidth?.constant = 0
        }
    }

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupElements()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Добавление элементов на ContentView и добавление их Constraint-ов

private extension CustomTableViewCell {
    func setupElements() {
        setupHeadingLabel()
        setupMyTextLabel()
        setupTimeLabel()
        addElementsToContentView()
        setupConstraints()
    }

    func setupHeadingLabel() {
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        headingLabel.font = Fonts.headingFont
        headingLabel.numberOfLines = Constants.labelsNumberOfLines
    }

    func setupMyTextLabel() {
        myTextLabel.translatesAutoresizingMaskIntoConstraints = false
        myTextLabel.font = Fonts.textFont
        myTextLabel.numberOfLines = Constants.labelsNumberOfLines
    }

    func setupTimeLabel() {
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.font = Fonts.textFont
        timeLabelWidth = timeLabel.widthAnchor.constraint(equalToConstant: Constants.notEmptyTimeLabelWidth)
    }

    func addElementsToContentView() {
        contentView.addSubview(headingLabel)
        contentView.addSubview(myTextLabel)
        contentView.addSubview(timeLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            headingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.headingLeadingAnchor),
            headingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.anchorConstant),
            headingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            myTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.anchorConstant),
            myTextLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: Constants.anchorConstant),
            myTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.anchorConstant),

            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.anchorConstant),
            timeLabelWidth ?? timeLabel.widthAnchor.constraint(equalToConstant: Constants.notEmptyTimeLabelWidth),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.anchorConstant),

            myTextLabel.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor),
        ])
    }
}
