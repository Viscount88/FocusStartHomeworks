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
        // Из-за того, что Array - потоконебезопасный, то пришлось исключить этот пункт из задания
//        var array = Array<Int>()
        let resultThreadSafeArray = ThreadSafeArray<Int>()
        let queue = DispatchQueue.global(qos: .userInteractive)

        dispathGroup.enter()
        queue.async {
            for number in 0...1000 {
                resultThreadSafeArray.append(number)
                // Из-за того, что Array - потоконебезопасный, то пришлось исключить этот пункт из задания
//                array.append(number)
            }
            dispathGroup.leave()
        }

        dispathGroup.enter()
        queue.async {
            for number in 0...1000 {
                resultThreadSafeArray.append(number)
                // Из-за того, что Array - потоконебезопасный, то пришлось исключить этот пункт из задания
//                array.append(number)
            }
            dispathGroup.leave()
        }

        dispathGroup.wait()
//        print("Количество элементов в обычном массиве: ",array.count)
        let safeThreadArrayCountText = "Количество элементов в потокобезопасном массиве: " + String(resultThreadSafeArray.count)
        print(safeThreadArrayCountText)
        resultLabel.text = safeThreadArrayCountText + "\n(Результат так же выведен print-ом)"
    }
}

