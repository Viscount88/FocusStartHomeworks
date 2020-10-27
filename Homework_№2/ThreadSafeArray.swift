//
//  ThreadSafeArray.swift
//  Homework_№2
//
//  Created by Андрей Шамин on 10/23/20.
//

import Foundation

final class ThreadSafeArray<Element> {
    private let safeQueue = DispatchQueue(label: "com.Lumko.Homework--2.safeQueue",
                                          attributes: .concurrent)
    private var array:[Element] = []

    var count: Int {
        safeQueue.sync {
            return array.count
        }
    }

    var description: String {
        safeQueue.sync {
            return self.array.description
        }
    }

    var isEmpty: Bool {
        safeQueue.sync {
            return self.array.isEmpty
        }
    }

    func append(_ item: Element){
        safeQueue.async(flags: .barrier) {
            self.array.append(item)
        }
    }

    func remove(at index: Int) {
        safeQueue.async(flags: .barrier) {
            self.array.remove(at: index)
        }
    }

    subscript(index: Int) -> Element? {
        get {
            return safeQueue.sync {
                self.array[index]
            }
        }
        set {
            safeQueue.sync(flags: .barrier) {
                self.array[index]
            }
        }
    }
}

extension ThreadSafeArray where Element: Equatable {
    func contains(_ element: Element) -> Bool {
        safeQueue.sync {
            return self.array.contains(element)
        }
    }
}
