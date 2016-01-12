//
//  Checklist.swift
//  Checklists
//
//  Created by iosdevlog on 16/1/3.
//  Copyright © 2016年 iosdevlog. All rights reserved.
//

import UIKit

class Checklist: NSObject, NSCoding {
    var name = ""
    var iconName = "No Icon"
    var items = [ChecklistItem]()
    
    convenience init(name: String) {
        self.init(name: name, iconName: "No Icon")
    }
    
    init(name: String, iconName: String) {
        self.name = name
        self.iconName = iconName
        
        super.init()
    }
    
    // MARK: - protocol NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "Name")
        aCoder.encodeObject(iconName, forKey: "IconName")
        aCoder.encodeObject(items, forKey: "Items")
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("Name") as! String
        iconName = aDecoder.decodeObjectForKey("IconName") as! String
        items = aDecoder.decodeObjectForKey("Items") as! [ChecklistItem]
        
        super.init()
    }
    
    // MARK: - Helper
    func countUncheckedItems() -> Int {
        var count = 0
        
        for item in items where !item.checked {
            count += 1
        }
        
        return count
    }
}
