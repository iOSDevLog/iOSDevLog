//
//  MapGPX.swift
//  Trax
//
//  Created by jiaxianhua on 15/10/5.
//  Copyright © 2015年 com.jiaxh. All rights reserved.
//

import MapKit

extension GPX.Waypoint: MKAnnotation {
    // MARK: - MKAnnotation
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var title: String? { return name }
    
    var subtitle: String? { return info }
    
    // MARK: - Links to Images
    var thumbnailURL: NSURL? { return getImageURLofType("thumbnail") }
    var imageURL: NSURL? { return getImageURLofType("large") }
    
    private func getImageURLofType(type: String) -> NSURL? {
        for link in links {
            if link.type == type {
                return link.url
            }
        }
        return nil
    }
}
