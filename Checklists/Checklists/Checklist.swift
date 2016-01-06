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
    var items = [ChecklistItem]()
    
    init(name: String) {
        self.name = name
        
        super.init()
    }
    
    // MARK: - protocol NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "Name")
        aCoder.encodeObject(items, forKey: "Items")
    }
    
    required init?(coder aDecoder: NSCoder) {
        aDecoder.decodeObjectForKey("Name") as! String
        aDecoder.decodeObjectForKey("Items") as! [ChecklistItem]
        
        super.init()
    }
}
