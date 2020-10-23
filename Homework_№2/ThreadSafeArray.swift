//
//  ThreadSafeArray.swift
//  Homework_№2
//
//  Created by Андрей Шамин on 10/23/20.
//

import Foundation

class ThreadSafeArray<Element: Equatable> {
    let safeQueue = DispatchQueue(label: "com.Lumko.Homework--2.safeQueue"
                                  , attributes: .concurrent)
    private var threadSafeArray:[Element] = []

    var count: Int {
        safeQueue.sync {
            return threadSafeArray.count
        }
    }

    var description: String {
        safeQueue.sync {
            return self.threadSafeArray.description
        }
    }

    var isEmpty: Bool {
        return threadSafeArray.isEmpty
    }

    func append(_ item: Element){
        safeQueue.async(flags: .barrier) {
            self.threadSafeArray.append(item)
        }
    }

    func remove(at index: Int) {
        safeQueue.async(flags: .barrier) {
            self.threadSafeArray.remove(at: index)
        }
    }

    subscript(index: Int) -> Element {
        return threadSafeArray[index]
    }

    func contains(_ element: Element) -> Bool {
        return threadSafeArray.contains(element)
    }
}
