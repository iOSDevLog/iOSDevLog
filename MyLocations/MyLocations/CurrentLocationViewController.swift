//
//  FirstViewController.swift
//  MyLocations
//
//  Created by iosdevlog on 16/1/27.
//  Copyright © 2016年 iosdevlog. All rights reserved.
//

import UIKit
import CoreLocation

class CurrentLocationViewController: UIViewController, CLLocationManagerDelegate {
    // MARK: - outlet
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tagButton: UIButton!
    @IBOutlet weak var getButton: UIButton!
    
    // MARK: - property
    let locationManager = CLLocationManager()
    var location: CLLocation?
    var updatingLocation = false
    var lastLocationError: NSError?
    let geocoder = CLGeocoder()
    var placemark: CLPlacemark?
    var performingReverseGeocoding = false
    var lastGeocodingError: NSError?
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        updateLabels()
        configureGetButton()
    }

    // MARK: action
    @IBAction func getLocation(sender: UIButton) {
        let authStatus = CLLocationManager.authorizationStatus()
        
        if authStatus == .NotDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        if authStatus == .Denied || authStatus == .Restricted {
            showLocationServicesDeniedAlert()
            return
        }
        
        if updatingLocation {
            stopLocationManager()
        } else {
            location = nil
            lastLocationError = nil
            startLocationManager()
        }
        updateLabels()
        configureGetButton()
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("didFailWithError \(error)")
        
        if error.code == CLError.LocationUnknown.rawValue {
            return
        }
        
        lastLocationError = error
        
        stopLocationManager()
        updateLabels()
        configureGetButton()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last
        print("didUpdateLocations \(newLocation)")
        
        if newLocation?.timestamp.timeIntervalSinceNow < -5 {
            return
        }
        
        if newLocation?.horizontalAccuracy < 0 {
            return
        }
        
        if location == nil || location?.horizontalAccuracy > newLocation?.horizontalAccuracy {
            lastLocationError = nil
            location = newLocation
            updateLabels()
            
            if newLocation?.horizontalAccuracy <= locationManager.desiredAccuracy {
                print("*** We're done!")
                stopLocationManager()
                configureGetButton()
            }
        }
        
        // geocoding here
        if !performingReverseGeocoding {
            print("*** Going to geocoding ***")
            
            performingReverseGeocoding = true
            
            geocoder.reverseGeocodeLocation(newLocation!, completionHandler: { (placemarks, error) -> Void in
                print("*** Found placemarks: \(placemarks), error: \(error) ***")
                
                self.lastLocationError = error
                if error == nil, let p = placemarks where !p.isEmpty {
                    self.placemark = p.last
                } else {
                    self.placemark = nil
                }
                
                self.performingReverseGeocoding = false
                self.updateLabels()
            })
        }
    }
    
    // MARK: - helper
    func showLocationServicesDeniedAlert() {
        let alert = UIAlertController(title: "Location Services Disabled", message: "Please enable location services for this app in Settings.", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alert.addAction(okAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func updateLabels() {
        if let location = location {
            latitudeLabel.text = String(format: "%.8f", location.coordinate.latitude)
            longitudeLabel.text = String(format: "%.8f", location.coordinate.longitude)
            tagButton.hidden = false
            messageLabel.text = ""
        } else {
            latitudeLabel.text = ""
            longitudeLabel.text = ""
            tagButton.hidden = true
            addressLabel.text = ""
            
            let statusMessage: String
            
            if let error = lastLocationError {
                if error.domain == kCLErrorDomain && error.code == CLError.Denied.rawValue {
                    statusMessage = "Location Services Disabled"
                } else {
                    statusMessage = "Error Getting Location"
                }
            } else if !CLLocationManager.locationServicesEnabled() {
                statusMessage = "Location Services Disabled"
            } else if updatingLocation {
                statusMessage = "Seaching..."
            } else {
                statusMessage = "Tap 'Get My Location' to Start"
            }
            
            messageLabel.text = statusMessage
        }
    }
    
    func startLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            updatingLocation = true
        }
    }
    
    func stopLocationManager() {
        if updatingLocation {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            updatingLocation = false
        }
    }
    
    func configureGetButton() {
        if updatingLocation {
            getButton.setTitle("Stop", forState: .Normal)
        } else {
            getButton.setTitle("Get My Location", forState: .Normal)
        }
    }
}

