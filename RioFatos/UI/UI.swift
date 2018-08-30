//
//  UI.swift
//  RioFatos
//
//  Created by Bruno Baring on 24/06/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import UIKit


let pw = UIScreen.main.bounds.width / 375
let ph = UIScreen.main.bounds.height / 667

struct DColor
{
    
    enum Color: String
    {
        case blue = "4990E2"
        case lightDark = "D8D8D8"
        case mediumDark = "404040"
        case dark = "696969"
        case darkDark = "090908"
        case white = "FFFFFF"
        case error = "FF0000"
    }
    
    static func getColor(byInt int: Int) -> UIColor
    {
        switch int {
        case 0:
            return getColor(.blue)
        case 1:
            return getColor(.lightDark)
        case 2:
            return getColor(.mediumDark)
        case 3:
            return getColor(.dark)
        case 4:
            return getColor(.darkDark)
        case 5:
            return getColor(.white)
        default:
            return getColor(.error)
        }
    }
    
    static func getColor(_ color: Color) -> UIColor
    {
        return UIColor(hex: color.rawValue)
    }
    
}
