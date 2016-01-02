//
//  ChecklistItem.swift
//  Checklists
//
//  Created by iosdevlog on 15/12/29.
//  Copyright © 2015年 iosdevlog. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, NSCoding {
    var text = ""
    var checked = false
    
    // MARK: init
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObjectForKey("Text") as! String
        checked = aDecoder.decodeBoolForKey("Checked")
        
        super.init()
    }
    
    override init() {
        super.init()
    }
    
    // MARK: - NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(text, forKey: "Text")
        aCoder.encodeBool(checked, forKey: "Checked")
    }
    
    func toggleChecked() {
        checked = !checked
    }
}