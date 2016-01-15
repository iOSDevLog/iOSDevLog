//
//  DataModel.swift
//  Checklists
//
//  Created by iosdevlog on 16/1/6.
//  Copyright © 2016年 iosdevlog. All rights reserved.
//

import Foundation

class DataModel {
    var lists = [Checklist]()
    
    var indexOfSelectedChecklist: Int {
        get {
            return NSUserDefaults.standardUserDefaults().integerForKey("ChecklistIndex")
        }
        set {
            NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: "ChecklistIndex")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    // MARK: - init
    init() {
        loadChecklists()
        
        registerDefaults()
        handleFirstTime()
    }
    
    // MARK: - save & load directory
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        return paths[0]
    }
    
    func dataFilePath() -> String {
        return (documentsDirectory() as NSString).stringByAppendingPathComponent("Checklists.plist")
    }
    
    // CURD Create / Update / Retrieve / Delete
    func saveChecklists() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(lists, forKey: "Checklists")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func loadChecklists() {
        // load path
        let path = dataFilePath()
        // file exist
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                lists = unarchiver.decodeObjectForKey("Checklists") as! [Checklist]
                unarchiver.finishDecoding()
                
                sortChecklists()
            }
        }
    }
    
    // MARK: - NSUserDefauts
    func registerDefaults() {
        let dictionary = ["ChecklistIndex": -1,
                            "FistTime": true,
                            "ChecklistItemID": 0
        ];
        
        NSUserDefaults.standardUserDefaults().registerDefaults(dictionary)
    }
    
    func handleFirstTime() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let firstTime = userDefaults.boolForKey("FistTime")
        
        if firstTime {
            let checklist = Checklist(name: "List")
            lists.append(checklist)
            indexOfSelectedChecklist = 0
            userDefaults.setBool(false, forKey: "FistTime")
            userDefaults.synchronize()
        }
    }
    
    // MARK: - Sorting the lists
    func sortChecklists() {
        lists.sortInPlace { (checklist1, checklist2) -> Bool in
            checklist1.name.localizedCaseInsensitiveCompare(checklist2.name) == .OrderedAscending
        }
    }
    
    class func nextChecklistItemID() -> Int {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let itemID = userDefaults.integerForKey("ChecklistItemID")
        userDefaults.setInteger(itemID+1, forKey: "ChecklistItemID")
        userDefaults.synchronize()
        
        return itemID
    }
}