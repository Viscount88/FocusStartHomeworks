//
//  FirstView.swift
//  Homework_№3
//
//  Created by Андрей Шамин on 10/30/20.
//

import UIKit

class FirstView: UIView {

    private enum Constants {
        static let firstLabelFont = UIFont.systemFont(ofSize: 14)
        static let secondLabelFont = UIFont(name: "Georgia", size: 18)
        static let thirdLabelFont = UIFont(name: "HoeflerText-BlackItalic", size: 20)
        static let firstButtonDiameter:CGFloat = 80
        static let capeCodImage = UIImage(named: "capeCodImage")
    }

    var firstLabel = UILabel()
    var secondLabel = UILabel()
    var thirdLabel = UILabel()
    var firstButton = UIButton()
    var secondButton = UIButton()
    var imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        setupElements()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupElements() {
        self.backgroundColor = .white
        setupLabels()
        setupButtons()
        setupImage()
    }

    private func setupLabels() {
        setupFirstLabel()
        setupSecondLabel()
        setupThirdLabel()
    }

    private func setupButtons() {
        setupFirstButton()
        setupSecondButton()
    }

    fileprivate func setupFirstLabel() {
        // Первый Label создал не из метода setupLabel потому что здесь пришлось бы делать менять метод setupLabel
        firstLabel.text = "Первый Label"
        firstLabel.font = Constants.firstLabelFont
        firstLabel.textAlignment = .center
        self.addSubview(firstLabel)
        // Layout
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            firstLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            firstLabel.widthAnchor.constraint(equalToConstant: 250),
            firstLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }

    fileprivate func setupSecondLabel() {
        setupLabel(secondLabel, withText: "Второй Label", font: Constants.secondLabelFont, topItem: self.firstLabel)
    }

    fileprivate func setupThirdLabel() {
        setupLabel(thirdLabel, withText: "Третий Label\nТретий Label", font: Constants.thirdLabelFont, numberOfLines: 2, topItem: self.secondLabel)
    }

    func setupFirstButton() {
        self.firstButton.layer.cornerRadius = Constants.firstButtonDiameter/2
        self.firstButton.backgroundColor = .black
        self.firstButton.setTitle("Кнопка", for: .normal)
        self.firstButton.setTitleColor(.white, for: .normal)
        self.firstButton.addTarget(self, action: #selector(firstButtonTapped), for: .touchUpInside)
        self.addSubview(firstButton)
        // Layout
        self.firstButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.firstButton.topAnchor.constraint(greaterThanOrEqualTo: self.thirdLabel.bottomAnchor, constant: 15),
            self.firstButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            self.firstButton.widthAnchor.constraint(equalToConstant: Constants.firstButtonDiameter),
            self.firstButton.heightAnchor.constraint(equalToConstant: Constants.firstButtonDiameter),
        ])
    }

    @objc func firstButtonTapped() {
        print("Была нажата круглая кнопка")
    }

    func setupSecondButton() {
        self.secondButton.layer.cornerRadius = 8
        self.secondButton.backgroundColor = .black
        self.secondButton.setTitle("Вторая кнопка", for: .normal)
        self.secondButton.setTitleColor(.white, for: .normal)
        self.secondButton.addTarget(self, action: #selector(secondButtonTapped), for: .touchUpInside)
        self.addSubview(secondButton)
        // Layout
        self.secondButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.secondButton.topAnchor.constraint(greaterThanOrEqualTo: self.firstButton.bottomAnchor, constant: 10),
            self.secondButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.secondButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.secondButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    @objc func secondButtonTapped() {
        print("Была нажата вторая кнопка")
    }

    fileprivate func setupImage() {
        let screenBounds = UIScreen.main.bounds
        let screenHeight = screenBounds.height
        self.imageView.image = Constants.capeCodImage
        self.addSubview(imageView)
        // Layout
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(greaterThanOrEqualTo: self.secondButton.bottomAnchor, constant: 20),
            self.imageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.imageView.heightAnchor.constraint(equalToConstant: screenHeight/3),
        ])
    }

    fileprivate func setupLabel(_ label:UILabel ,withText text:String,font: UIFont?,numberOfLines:Int = 1, topItem: UIView) {
        label.text = text
        label.font = font
        label.textAlignment = .center
        label.numberOfLines = numberOfLines
        self.addSubview(label)
        // Layout
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topItem.bottomAnchor, constant: 6),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            label.widthAnchor.constraint(equalToConstant: 250),
            label.heightAnchor.constraint(greaterThanOrEqualToConstant: 40)
        ])
        
    }


}
