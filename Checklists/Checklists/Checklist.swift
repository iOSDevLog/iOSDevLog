//
//  Checklist.swift
//  Checklists
//
//  Created by iosdevlog on 16/1/3.
//  Copyright © 2016年 iosdevlog. All rights reserved.
//

import UIKit

class Checklist: NSObject {
    var name = ""
    var items = [ChecklistItem]()
    
    init(name: String) {
        self.name = name
        
        super.init()
    }
}
