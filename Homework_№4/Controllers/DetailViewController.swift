//
//  ViewController.swift
//  Homework_№4
//
//  Created by Андрей Шамин on 11/4/20.
//

import UIKit

final class DetailViewController: UIViewController {

    var navigationTitle = "Deatail"
    var chosenIndexPath:IndexPath?
    var titleText = "Текст Label-а"

    override func loadView() {
        view = DetailView(frame: .zero,labelText: titleText, withTableViewIndexPath: chosenIndexPath ?? IndexPath(row: 0, section: 0))
        navigationItem.title = navigationTitle
    }
}
