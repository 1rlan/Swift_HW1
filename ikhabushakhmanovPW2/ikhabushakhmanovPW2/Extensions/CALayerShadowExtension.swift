//
//  CALayerExtension.swift
//  ikhabushakhmanovPW2
//
//  Created by Ирлан Абушахманов on 29.09.2022.
//

import UIKit

extension CALayer {
    
    func applyShadow(radiusBlur : CGFloat = 5, inlineOpacity : Float = 1, bottomMargin : CGFloat = 8) {
        shadowColor = UIColor.systemGray4.cgColor
        shadowOffset = CGSize(width: 0.0, height: bottomMargin)
        shadowRadius = radiusBlur
        shadowOpacity = inlineOpacity
        masksToBounds = false
        
    }
}
