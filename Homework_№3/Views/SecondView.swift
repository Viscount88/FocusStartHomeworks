//
//  SecondView.swift
//  Homework_№3
//
//  Created by Андрей Шамин on 10/30/20.
//

import UIKit

class SecondView: UIView {

    private enum Constants {
        static let capeCodImage = UIImage(named: "capeCodImage")
        static let anchorConstant:CGFloat = 20
    }

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.capeCodImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста Текст, много текста, очень много текста "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Главный Label"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    var verticalConstraints: [NSLayoutConstraint] = []
    var horizontalConstraints: [NSLayoutConstraint] = []


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupElements()
    }
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setupVerticalConstraints() {
        verticalConstraints = [
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.anchorConstant),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalToConstant: 250),

            mainLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            mainLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.anchorConstant),
            mainLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            mainLabel.heightAnchor.constraint(equalToConstant: 30),

            textLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.anchorConstant),
            textLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: Constants.anchorConstant),
            textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.anchorConstant),
            textLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Constants.anchorConstant)
        ]
    }

    fileprivate func setupHorizontalConstraints() {
        horizontalConstraints = [
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.anchorConstant),
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.anchorConstant),
            imageView.widthAnchor.constraint(equalToConstant: 125),
            imageView.heightAnchor.constraint(equalToConstant: 125),

            mainLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 0),
            mainLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 0),
            mainLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            mainLabel.heightAnchor.constraint(equalToConstant: 30),

            textLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.anchorConstant),
            textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.anchorConstant),
            textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.anchorConstant),
            textLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Constants.anchorConstant)
        ]
    }

    fileprivate func setupScrollViewConstraints() {
        scrollView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8.0).isActive = true
    }

    fileprivate func addSubviewsToScrollView() {
        scrollView.addSubview(imageView)
        scrollView.addSubview(mainLabel)
        scrollView.addSubview(textLabel)
    }

    private func setupElements() {
        self.addSubview(scrollView)
        setupVerticalConstraints()
        setupHorizontalConstraints()
        setupScrollViewConstraints()
        addSubviewsToScrollView()
        activateCurrentConstraints()
    }

    private func activateCurrentConstraints() {
        NSLayoutConstraint.deactivate(self.verticalConstraints + self.horizontalConstraints)
        if self.traitCollection.verticalSizeClass == .regular {
            NSLayoutConstraint.activate(self.verticalConstraints)
        } else {
            NSLayoutConstraint.activate(self.horizontalConstraints)
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.activateCurrentConstraints()
    }

}
