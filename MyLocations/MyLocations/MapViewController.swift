//
//  MapViewController.swift
//  MyLocations
//
//  Created by iosdevlog on 16/2/18.
//  Copyright © 2016年 iosdevlog. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController {
    // MARK: outlet
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: property
    var managedObjectContext: NSManagedObjectContext!
    
    var locations = [Location]()
    
    // MARK: - lifeCycle
    override func viewDidLoad() { super.viewDidLoad()

        updateLocations()
    }
    
    // MARK: - action
    @IBAction func showUser() {
        let region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 1000, 1000)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
    
    // MARK: - helper
    func updateLocations() {
        mapView.removeAnnotations(locations)
        
        let entity = NSEntityDescription.entityForName("Location", inManagedObjectContext: managedObjectContext)
        
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entity
        
        locations = try! managedObjectContext.executeFetchRequest(fetchRequest) as! [Location]
        mapView.addAnnotations(locations)
    }
}

extension MapViewController: MKMapViewDelegate {
}