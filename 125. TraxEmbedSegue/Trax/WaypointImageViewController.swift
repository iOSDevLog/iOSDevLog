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
    
    // normally an embedded MVC would be more complicated
    // than this simple map view controller
    // but there is not time in a demo to create that
    func updateEmbeddedMap() {
        
    }
}
