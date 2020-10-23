//
//  ViewController.swift
//  Homework_№2
//
//  Created by Андрей Шамин on 10/23/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var resultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func showResultsAction(_ sender: Any) {
        let dispathGroup = DispatchGroup()
//        var array = Array<Int>()
        let resultThreadSafeArray = ThreadSafeArray<Int>()
        let queue = DispatchQueue.global(qos: .userInteractive)

        dispathGroup.enter()
        queue.async {
            for number in 0...1000 {
                resultThreadSafeArray.append(number)
//                array.append(number)
            }
            dispathGroup.leave()
        }

        dispathGroup.enter()
        queue.async {
            for number in 0...1000 {
                resultThreadSafeArray.append(number)
//                array.append(number)
            }
            dispathGroup.leave()
        }

        dispathGroup.wait()
//        print("Количество элементов в обычном массиве: ",array.count)
        print("Количество элементов в потокобезопасном массиве: ",resultThreadSafeArray.count)
        resultLabel.text = "Количество элементов в потокобезопасном массиве: \(resultThreadSafeArray.count)\n(Результат так же выведен print-ом)"
    }
}

