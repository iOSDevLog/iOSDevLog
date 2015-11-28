//
//  DLView.swift
//  211. StackView
//
//  Created by iosdevlog on 15/11/28.
//  Copyright © 2015年 iosdevlog. All rights reserved.
//

import UIKit

@IBDesignable
class DLView: UIImageView {
    @IBInspectable var borderColor: UIColor = UIColor.clearColor() {
        didSet {
            layer.borderColor = borderColor.CGColor
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
}
