//
//  SecondView.swift
//  Homework_№3
//
//  Created by Андрей Шамин on 10/30/20.
//

import UIKit

final class SecondView: UIView {

    // MARK: - Constants

    private enum Constants {
        static let capeCodImage = UIImage(named: "capeCodImage")
        static let anchorConstant:CGFloat = 16
        static let horizontalOrientationImageSize:CGSize = CGSize(width: 125, height: 125)
        static let labelHeight:CGFloat = 30
    }

    // MARK: - Views

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

    // MARK: - Properties

    private var verticalConstraints: [NSLayoutConstraint] = []
    private var horizontalConstraints: [NSLayoutConstraint] = []
    private var previousTraitCollection: UITraitCollection?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        setupElements()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        activateCurrentConstraints()
    }
}

// MARK: - Установка constraint-ов для элементов

private extension SecondView {
    func setupElements() {
        self.addSubview(scrollView)
        setupVerticalConstraints()
        setupHorizontalConstraints()
        setupScrollView()
        addSubviewsToScrollView()
        activateCurrentConstraints()
    }

    func setupVerticalConstraints() {
        verticalConstraints = [
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.anchorConstant),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 250),

            mainLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.anchorConstant),
            mainLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight),

            textLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.anchorConstant),
            textLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: Constants.anchorConstant),
            textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.anchorConstant),
            textLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Constants.anchorConstant)
        ]
    }

    func setupHorizontalConstraints() {
        horizontalConstraints = [
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 2*Constants.anchorConstant),
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.anchorConstant),
            imageView.widthAnchor.constraint(equalToConstant: Constants.horizontalOrientationImageSize.width),
            imageView.heightAnchor.constraint(equalToConstant: Constants.horizontalOrientationImageSize.height),

            mainLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor),
            mainLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            mainLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight),

            textLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 2*Constants.anchorConstant),
            textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.anchorConstant),
            textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.anchorConstant),
            textLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Constants.anchorConstant)
        ]
    }

    func setupScrollView() {
        scrollView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.anchorConstant/2).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.anchorConstant/2).isActive = true
    }

    func addSubviewsToScrollView() {
        scrollView.addSubview(imageView)
        scrollView.addSubview(mainLabel)
        scrollView.addSubview(textLabel)
    }

    func activateCurrentConstraints() {
        guard traitCollection.horizontalSizeClass != previousTraitCollection?.horizontalSizeClass ||
                traitCollection.verticalSizeClass != previousTraitCollection?.verticalSizeClass else { return }

        NSLayoutConstraint.deactivate(self.verticalConstraints + self.horizontalConstraints)
        if self.traitCollection.verticalSizeClass == .regular {
            NSLayoutConstraint.activate(self.verticalConstraints)
        } else {
            NSLayoutConstraint.activate(self.horizontalConstraints)
        }
        previousTraitCollection = traitCollection
    }
}
