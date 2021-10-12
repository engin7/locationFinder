//
//  LocationProvider.swift
//  locationFinder
//
//  Created by Engin KUK on 12.10.2021.
//

import UIKit
import CoreLocation
import SwiftCoroutine

class LocationProvider: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationProvider()
    let locationManager = CLLocationManager()

    override init() {
            super.init()
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
        }
     
    var locationsUpdated: (lat: CGFloat,long: CGFloat)?
     
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied) {
            // The user denied authorization
        } else if (status == CLAuthorizationStatus.authorizedAlways) {
            // The user accepted authorization
            locationManager.requestLocation()
        } else if (status == CLAuthorizationStatus.authorizedWhenInUse) {
            // The user accepted authorization
            locationManager.requestLocation()
        }
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let location = locations.first {
            let latitude =  CGFloat(location.coordinate.latitude)
            let longitude = CGFloat(location.coordinate.longitude)
            // Handle location update
            locationsUpdated = (latitude, longitude)
            print(locationsUpdated)
        }
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        // Handle failure to get a user’s location
    }
   
    func getMyLocation() -> CoFuture<(lat: CGFloat,long: CGFloat)?> {
        let promise = CoPromise<(lat: CGFloat,long: CGFloat)?>()
        if let loc = locationsUpdated {
            promise.success(loc)
        }
        return promise
    }
    
}
