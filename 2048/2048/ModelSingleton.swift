//
//  ModelSingleton.swift
//  2048
//
//  Created by JiaXianhua on 15/9/14.
//  Copyright (c) 2015年 jiaxianhua. All rights reserved.
//

import UIKit

class ModelSingleton: NSObject {
    var tiles: Dictionary<NSIndexPath, Int>!
    
    let dimension: Int = 4
    let threshold: Int = 2048
    
    class var sharedInstance : ModelSingleton {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : ModelSingleton? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = ModelSingleton()
            Static.instance?.tiles = Dictionary<NSIndexPath, Int>()
        }
        return Static.instance!
    }
}
