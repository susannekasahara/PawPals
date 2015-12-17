//
//  buttons.swift
//  PawPals
//
//  Created by Susanne Burnham on 12/15/15.
//  Copyright © 2015 Susanne Kasahara. All rights reserved.
//

import UIKit

@IBDesignable class buttons: UIButton {
    
    override func drawRect(rect: CGRect) {
        
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor
        layer.masksToBounds = true
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: CGColor = UIColor.whiteColor().CGColor
}
