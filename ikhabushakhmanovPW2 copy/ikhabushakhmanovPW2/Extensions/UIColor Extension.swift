//
//  UIColor Extension.swift
//  ikhabushakhmanovPW3
//
//  Created by Ирлан Абушахманов on 24.10.2022.
//

import UIKit


extension UIColor {
    
    func getComponents() -> [CGFloat] {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return [red, green, blue, alpha]
    }
}
