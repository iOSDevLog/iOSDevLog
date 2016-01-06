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
    
    // MARK: - init
    init() {
        loadChecklists()
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
            }
        }
    }
}