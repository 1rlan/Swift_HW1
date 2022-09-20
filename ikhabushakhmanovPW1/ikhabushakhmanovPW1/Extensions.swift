//
//  extensions.swift
//  ikhabushakhmanovPW1
//
//  Created by Ирлан Абушахманов on 20.09.2022.
//

import UIKit

extension UIColor {
    convenience init(hexString : String) {
        let charArray = Array(hexString)
        self.init(red: CGFloat(Int(String(charArray[0]) + String(charArray[1]), radix: 16) ?? 0) / 255.0,
                  green: CGFloat(Int(String(charArray[2]) + String(charArray[3]), radix: 16) ?? 0) / 255.0,
                  blue:  CGFloat(Int(String(charArray[4]) + String(charArray[5]), radix: 16) ?? 0) / 255.0,
                  alpha: 1)
    }
    
    
    // generating HEX string
    static func hexGenerator() -> String {
        var hexString = ""
        for _ in 0...2 {
            hexString += String(format:"%02X", Int.random(in : 0...255))
        }
        return hexString;
    }
}
