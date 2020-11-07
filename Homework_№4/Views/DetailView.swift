//
//  DetailView.swift
//  Homework_№4
//
//  Created by Андрей Шамин on 11/4/20.
//

import UIKit

final class DetailView: UIView {

    // MARK: - Images

    enum Image: Int {
        case firstImage = 0
        case secondImage = 1
        case thirdImage = 2
        case fourthImage = 3
        case fifthImage = 4
        case sixthImage = 5

        var image: UIImage {
            switch self {
            case  .firstImage:
                return UIImage(named: "firstImage") ?? UIImage()
            case  .secondImage:
                return UIImage(named: "secondImage") ?? UIImage()
            case  .thirdImage:
                return UIImage(named: "thirdImage") ?? UIImage()
            case  .fourthImage:
                return UIImage(named: "fourthImage") ?? UIImage()
            case  .fifthImage:
                return UIImage(named: "fifthImage") ?? UIImage()
            case  .sixthImage:
                return UIImage(named: "sixthImage") ?? UIImage()
            default:
                return UIImage()
            }
        }
    }
    // MARK: - Constants

    private enum Constants {
        static let anchorConstant:CGFloat = 16
        static let imagesAnchorConstant:CGFloat = 32
        static let imagesSize = CGSize(width: 250, height: 250)
        static let cornerRadius:CGFloat = 15
        static let shadowRadius:CGFloat = 10
        static let shadowOpacity:Float = 1
        static let textWidthMultiplier:CGFloat = 0.85
        static let labelNumberOfLines = 0
    }

    // MARK: - Views

    let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = Constants.labelNumberOfLines
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let viewForFirstImage: UIView = {
        let containerView = UIView()
        containerView.clipsToBounds = false
        containerView.frame.size = CGSize(width: Constants.imagesSize.width,
                                          height: Constants.imagesSize.height)
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = Constants.shadowOpacity
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowRadius = Constants.shadowRadius
        containerView.layer.cornerRadius = Constants.cornerRadius
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: Constants.cornerRadius).cgPath
        return containerView
    }()

    let firstImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.cornerRadius
        return imageView
    }()

    let viewForSecondImage: UIView = {
        let containerView = UIView()
        containerView.clipsToBounds = false
        containerView.frame.size = CGSize(width: Constants.imagesSize.width,
                                          height: Constants.imagesSize.height)

        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = Constants.shadowOpacity
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowRadius = Constants.shadowRadius
        containerView.layer.cornerRadius = Constants.cornerRadius
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: Constants.cornerRadius).cgPath
        return containerView
    }()

    let secondImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.cornerRadius
        return imageView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        setupElements()
    }

    init(frame: CGRect,labelText:String, withTableViewIndexPath indexPath:IndexPath) {
        super.init(frame: frame)
        setupElements(forIndexPath: indexPath)
        dataForView(withIndexPath: indexPath,labelText:labelText)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Добавление элементов на scrollView и установка constraint-ов для элементов

private extension DetailView {
    func setupElements(forIndexPath indexPath: IndexPath = IndexPath(row: 0, section: 0)) {
        self.backgroundColor = .white
        self.addSubview(scrollView)
        setupScrollView()
        addSubviewsToScrollView()
        setupLabelConstraints()
        setupFirstImageConstraints()
        setupSecondImageConstraints()
    }

    func setupLabelConstraints() {
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.anchorConstant),
            textLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: Constants.textWidthMultiplier),
            textLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.anchorConstant),
            textLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -Constants.anchorConstant),
        ])
    }

    func setupFirstImageConstraints() {
        NSLayoutConstraint.activate([
            viewForFirstImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            viewForFirstImage.widthAnchor.constraint(equalToConstant: Constants.imagesSize.width),
            viewForFirstImage.heightAnchor.constraint(equalToConstant: Constants.imagesSize.height),
            viewForFirstImage.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: Constants.anchorConstant),
        ])
        viewForFirstImage.addSubview(firstImageView)
        NSLayoutConstraint.activate([
            firstImageView.leadingAnchor.constraint(equalTo: viewForFirstImage.leadingAnchor),
            firstImageView.topAnchor.constraint(equalTo: viewForFirstImage.topAnchor),
            firstImageView.trailingAnchor.constraint(equalTo: viewForFirstImage.trailingAnchor),
            firstImageView.bottomAnchor.constraint(equalTo: viewForFirstImage.bottomAnchor)
        ])
    }

    func setupSecondImageConstraints() {
        NSLayoutConstraint.activate([
            viewForSecondImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            viewForSecondImage.widthAnchor.constraint(equalToConstant: Constants.imagesSize.width),
            viewForSecondImage.heightAnchor.constraint(equalToConstant: Constants.imagesSize.height),
            viewForSecondImage.topAnchor.constraint(equalTo: viewForFirstImage.bottomAnchor, constant: Constants.imagesAnchorConstant),
            viewForSecondImage.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Constants.imagesAnchorConstant),
        ])
        viewForSecondImage.addSubview(secondImageView)
        NSLayoutConstraint.activate([
            secondImageView.leadingAnchor.constraint(equalTo: viewForSecondImage.leadingAnchor),
            secondImageView.topAnchor.constraint(equalTo: viewForSecondImage.topAnchor),
            secondImageView.trailingAnchor.constraint(equalTo: viewForSecondImage.trailingAnchor),
            secondImageView.bottomAnchor.constraint(equalTo: viewForSecondImage.bottomAnchor)
        ])
    }

    func setupScrollView() {
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.anchorConstant),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func addSubviewsToScrollView() {
        scrollView.addSubview(textLabel)
        scrollView.addSubview(viewForFirstImage)
        scrollView.addSubview(viewForSecondImage)
    }

    func dataForView(withIndexPath indexPath:IndexPath,labelText:String) {
        firstImageView.image = Image.init(rawValue: indexPath.row)?.image
        secondImageView.image = Image.init(rawValue: indexPath.row + 1)?.image

        self.textLabel.text = labelText
    }
}
