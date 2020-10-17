//
//  Car.swift
//  Homework №1
//
//  Created by Андрей Шамин on 10/15/20.
//

import Foundation

struct Car {
    let manufacturer: String
    let model: String
    let body: Body
    let yearOfIssue: Int?
    let carNumber: String?
}

enum Body:String, CaseIterable {
    case sedan = "Седан"
    case hatchback = "Хэтчбек"
    case universal = "Универсал"
    case liftback = "Лифтбэк"
    case coupe = "Купе"
    case cabrio = "Кабриолет"
    case rodster = "Родстер"
    case stretch = "Стретч"
    case targa = "Тарга"
    case suv = "Внедорожник"
    case crossover = "Кроссовер"
    case pickup = "Пикап"
    case van = "Фургон"
    case minivan = "Минивэн"
}
