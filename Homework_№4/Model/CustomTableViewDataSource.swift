//
//  CustomTableViewDataSource.swift
//  Homework_№4
//
//  Created by Андрей Шамин on 11/6/20.
//

import UIKit

final class CustomTableViewDataSource: NSObject {

    // MARK: Properties
    var dataArray = [DataModel]()
}

// MARK: UITableViewDataSource
extension CustomTableViewDataSource: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? CustomTableViewCell
        else { assertionFailure(); return UITableViewCell()}

        let object = dataArray[indexPath.row]
        cell.setupCell(heading: object.heading, text: object.text, time: object.time)
        return cell
    }
}
