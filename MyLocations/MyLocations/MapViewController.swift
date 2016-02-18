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
    @IBOutlet weak var mapView: MKMapView!
    
    var managedObjectContext: NSManagedObjectContext!
    
    @IBAction func showUser() {
        let region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 1000, 1000)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
}

extension MapViewController: MKMapViewDelegate {
}