//
//  LocationDetailsViewController.swift
//  MyLocations
//
//  Created by iosdevlog on 16/2/15.
//  Copyright © 2016年 iosdevlog. All rights reserved.
//

import UIKit
import CoreLocation

class LocationDetailsViewController: UITableViewController {
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var placemark: CLPlacemark?
    
    @IBAction func done() { dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancel() { dismissViewControllerAnimated(true, completion: nil)
    }
}