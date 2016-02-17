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
            tableView.reloadData()
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
            let cell = tableView.dequeueReusableCellWithIdentifier("LocationCell", forIndexPath: indexPath) as! LocationCell

            let location = locations[indexPath.row]
        
            cell.configureForLocation(location)
        
        return cell
    }
    
    // MARK: - prepareForSegue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EditLocation" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! LocationDetailsViewController
            controller.managedObjectContext = managedObjectContext
            
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                let location = locations[indexPath.row]
                controller.locationToEdit = location
            }
        }
    }
}
