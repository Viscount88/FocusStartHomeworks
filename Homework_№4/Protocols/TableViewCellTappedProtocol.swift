//
//  TableViewCellTapped.swift
//  Homework_№4
//
//  Created by Андрей Шамин on 11/6/20.
//

import UIKit

protocol TableViewCellTappedDelegate: class {
    func showNavigationViewController(navigationController: UINavigationController)
}
