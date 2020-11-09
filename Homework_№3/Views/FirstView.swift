//
//  FirstView.swift
//  Homework_№3
//
//  Created by Андрей Шамин on 10/30/20.
//

import UIKit

final class FirstView: UIView {

    // MARK: - Constants
    private enum Fonts {
        static let firstLabelFont = UIFont.systemFont(ofSize: 14)
        static let secondLabelFont = UIFont(name: "Georgia", size: 18)
        static let thirdLabelFont = UIFont(name: "HoeflerText-BlackItalic", size: 20)
    }

    private enum Constants {
        static let firstButtonDiameter:CGFloat = 80
        static let capeCodImage = UIImage(named: "capeCodImage")
        static let screenHeight = UIScreen.main.bounds.height
        static let screenWidth = UIScreen.main.bounds.width
        static let anchorConstant:CGFloat = 16
        static let stackViewSpacing:CGFloat = 16
        static let labelLineSpace:CGFloat = 20
        static let widthOfItems:CGFloat = screenWidth*0.85
        static let seconButtonHeight:CGFloat = 40
    }

    // MARK: - Properties

    let stackView   = UIStackView()
    let activityIndicator = UIActivityIndicatorView()

    // MARK: - Views

    var firstLabel: UILabel = {
        let firstLabel = UILabel()
        firstLabel.text  = "Перый Label"
        firstLabel.textAlignment = .center
        firstLabel.font = Fonts.firstLabelFont
        return firstLabel
    }()

    var secondLabel: UILabel = {
        let secondLabel = UILabel()
        secondLabel.text  = "Второй Label"
        secondLabel.textAlignment = .center
        secondLabel.font = Fonts.secondLabelFont
        return secondLabel
    }()

    var thirdLabel: UILabel = {
        let thirdLabel = UILabel()
        thirdLabel.text  = "Третий Label\nТретий Label"
        thirdLabel.textAlignment = .center
        thirdLabel.numberOfLines = 2
        thirdLabel.font = Fonts.thirdLabelFont
        return thirdLabel
    }()

    var firstButton: UIButton = {
        let firstButton = UIButton()
        firstButton.backgroundColor = .black
        firstButton.setTitle("Кнопка", for: .normal)
        firstButton.setTitleColor(.white, for: .normal)
        firstButton.addTarget(self, action: #selector(firstButtonTapped), for: .touchUpInside)
        return firstButton
    }()

    var secondButton: UIButton = {
        let secondButton = UIButton()
        secondButton.layer.cornerRadius = 8
        secondButton.backgroundColor = .black
        secondButton.setTitle("Вторая кнопка", for: .normal)
        secondButton.setTitleColor(.white, for: .normal)
        secondButton.addTarget(self, action: #selector(secondButtonTapped), for: .touchUpInside)
        return secondButton
    }()

    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.capeCodImage
        return imageView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Установка constraint-ов для элементов

private extension FirstView {
    func setupElements() {
        self.backgroundColor = .systemBackground
        setupImage()
        setupActivityIndicator()
        setupLabels()
        setupButtons()
        setupStackView()
    }
    
    func setupImage() {
        self.addSubview(imageView)
        // Layout
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.anchorConstant/2),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.anchorConstant),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.anchorConstant),
            imageView.heightAnchor.constraint(equalToConstant: Constants.screenHeight/3),
        ])
    }
    
    func setupActivityIndicator() {
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        self.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: self.imageView.centerXAnchor),
        ])
    }
    
    func setupLabels() {
        setupFirstLabel()
        setupSecondLabel()
        setupThirdLabel()
    }
    
    func setupButtons() {
        setupFirstButton()
        setupSecondButton()
    }
    
    func setupFirstLabel() {
        firstLabel.widthAnchor.constraint(equalToConstant: Constants.widthOfItems).isActive = true
        firstLabel.heightAnchor.constraint(equalToConstant: Constants.labelLineSpace).isActive = true
    }
    
    func setupSecondLabel() {
        secondLabel.widthAnchor.constraint(equalToConstant: Constants.widthOfItems).isActive = true
        secondLabel.heightAnchor.constraint(equalToConstant: Constants.labelLineSpace).isActive = true
    }
    
    func setupThirdLabel() {
        thirdLabel.widthAnchor.constraint(equalToConstant: Constants.widthOfItems).isActive = true
        thirdLabel.heightAnchor.constraint(equalToConstant: Constants.labelLineSpace*2).isActive = true
    }
    
    func setupFirstButton() {
        firstButton.widthAnchor.constraint(equalToConstant: Constants.firstButtonDiameter).isActive = true
        firstButton.heightAnchor.constraint(equalToConstant: Constants.firstButtonDiameter).isActive = true
        firstButton.layer.cornerRadius = Constants.firstButtonDiameter/2
    }
    
    @objc func firstButtonTapped() {
        print("Была нажата круглая кнопка")
    }
    
    func setupSecondButton() {
        secondButton.widthAnchor.constraint(equalToConstant: Constants.widthOfItems).isActive = true
        secondButton.heightAnchor.constraint(equalToConstant: Constants.seconButtonHeight).isActive = true
    }
    
    @objc func secondButtonTapped() {
        print("Была нажата вторая кнопка")
    }
    
    func setupStackView() {
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = Constants.stackViewSpacing
        
        stackView.addArrangedSubview(firstLabel)
        stackView.addArrangedSubview(secondLabel)
        stackView.addArrangedSubview(thirdLabel)
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
        
        //Constraints
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constants.anchorConstant/2).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.imageView.topAnchor, constant: -Constants.anchorConstant/2).isActive = true
    }
}
