//
//  ChecklistItem.swift
//  Checklists
//
//  Created by iosdevlog on 15/12/29.
//  Copyright © 2015年 iosdevlog. All rights reserved.
//

import Foundation

class ChecklistItem {
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}