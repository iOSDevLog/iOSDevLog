//
//  LocationsTableViewController.swift
//  MyLocations
//
//  Created by iosdevlog on 16/2/17.
//  Copyright © 2016年 iosdevlog. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class LocationsTableViewController: UITableViewController {
    // MARK: - property
    var managedObjectContext: NSManagedObjectContext!
    var locations = [Location]()
    
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The NSFetchRequest is the object that describes which objects you’re going to fetch from the data store
        let fetchRequest = NSFetchRequest()
        // The NSEntityDescription tells the fetch request you’re looking for Location entities.
        let entity = NSEntityDescription.entityForName("Location", inManagedObjectContext: managedObjectContext)
        fetchRequest.entity = entity
        // The NSSortDescriptor tells the fetch request to sort on the date attribute, in ascending order.
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            // Now that you have the fetch request, you can tell the context to execute it.
            let foundObjects = try managedObjectContext.executeFetchRequest(fetchRequest)
            
            // casting foundObjects from an array of AnyObjects to an array of Location objects.
            locations = foundObjects as! [Location]
        } catch {
            fatalCoreDataError(error)
        }
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier( "LocationCell", forIndexPath: indexPath)
        let location = locations[indexPath.row]
        
        let descriptionLabel = cell.viewWithTag(100) as! UILabel
        descriptionLabel.text = location.locationDescription
        
        let addressLabel = cell.viewWithTag(101) as! UILabel
        if let placemark = location.placemark {
            var text = ""
            if let s = placemark.subThoroughfare {
                text += s + " "
            }
    
            if let s = placemark.thoroughfare {
                text += s + ", "
            }
            
            if let s = placemark.locality {
                text += s
            }
            addressLabel.text = text
        } else {
            addressLabel.text = ""
        }
        
        return cell
    }
}
