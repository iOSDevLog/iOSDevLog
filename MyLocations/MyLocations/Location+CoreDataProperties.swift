//
//  Location+CoreDataProperties.swift
//  MyLocations
//
//  Created by iosdevlog on 16/2/16.
//  Copyright © 2016年 iosdevlog. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Location {

    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var date: NSTimeInterval
    @NSManaged var locationDescription: String?
    @NSManaged var category: String?
    @NSManaged var placemark: NSObject?

}
