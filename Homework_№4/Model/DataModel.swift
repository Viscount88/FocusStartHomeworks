//
//  DataModel.swift
//  Homework_№4
//
//  Created by Андрей Шамин on 11/6/20.
//

import Foundation

struct DataModel {
    let heading:String
    let text:String
    let time:String
}

extension DataModel {
    static func getDataModel() -> [Self] {
        let dataModel:[DataModel] = [DataModel(heading: "Заголовок1",
                                               text: "Текст1",
                                               time: "16:27"),
                                     DataModel(heading: "Заголовок2\nЗаголовок2",
                                               text: "Текст2",
                                               time: "16:28"),
                                     DataModel(heading: "Заголовок3",
                                               text: "Больше текста, и времени нет 12Pro Max и еще =)",
                                               time: ""),
                                     DataModel(heading: "Заголовок4",
                                               text: "Больше текста, и времени нет 12Pro Max и еще =)\nБольше текста, и времени нет 12Pro Max и еще =)",
                                               time: "16:30"),
                                     DataModel(heading: "Заголовок5",
                                               text: "",
                                               time: "")
        ]
        return dataModel
    }
}
