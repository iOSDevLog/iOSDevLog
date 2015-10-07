//
//  WaypointImageViewController.swift
//  Trax
//
//  Created by jiaxianhua on 15/10/7.
//  Copyright © 2015年 com.jiaxh. All rights reserved.
//

import UIKit

class WaypointImageViewController: ImageViewController {
    var waypoint: GPX.Waypoint {
        didSet {
            imageURL = waypoint.imageURL // our super's Model
            title = waypoint.name
            updateEmbeddedMap()
        }
    }
    
    // we "prepare" for the embed segue
    // by grabbing the MVC that is embedded
    // we can then update it whenever it might need it
    var smvc: SimpleMapViewController?
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Embed Map" {
            smvc = segue.destinationViewController as? SimpleMapViewController
            updateEmbeddedMap()
        }
    }
    
    // normally an embedded MVC would be more complicated
    // than this simple map view controller
    // but there is not time in a demo to create that
    func updateEmbeddedMap() {
        
    }
}
