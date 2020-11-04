//
//  DeviceTraitStatus.swift
//  Homework_№4
//
//  Created by Андрей Шамин on 11/4/20.
//

import UIKit

// Определение SizeClass-а
enum DeviceTraitStatus {
    ///IPAD and others: Width: Regular, Height: Regular
    case wRhR
    ///Any IPHONE Portrait Width: Compact, Height: Regular
    case wChR
    ///IPHONE Plus/Max Landscape Width: Regular, Height: Compact
    case wRhC
    ///IPHONE landscape Width: Compact, Height: Compact
    case wChC

    static var current:DeviceTraitStatus{
        switch (UIScreen.main.traitCollection.horizontalSizeClass, UIScreen.main.traitCollection.verticalSizeClass){
        case (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular):
            return .wRhR
        case (UIUserInterfaceSizeClass.compact, UIUserInterfaceSizeClass.regular):
            return .wChR
        case (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.compact):
            return .wRhC
        case (UIUserInterfaceSizeClass.compact, UIUserInterfaceSizeClass.compact):
            return .wChC
        default:
            return .wChR
        }
    }
}
