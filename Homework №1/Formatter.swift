//
//  Formatter.swift
//  Homework №1
//
//  Created by Андрей Шамин on 11/9/20.
//

import Foundation

final class Formatter {
    static func allowCharaters(_ charaters:String, inString string:String) -> Bool{
        let allowedCharacters = CharacterSet(charactersIn:charaters)
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
