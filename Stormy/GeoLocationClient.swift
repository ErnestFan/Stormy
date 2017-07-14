//
//  GeoLocationClient.swift
//  Stormy
//
//  Created by Ernest Fan on 2017-07-09.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
import CoreLocation

class GeoLocationClient: NSObject, CLLocationManagerDelegate{
    
    var locationManager: CLLocationManager = CLLocationManager()
    
    var coordinate: Coordinate = Coordinate(latitude: 33.0, longitude: 120.0)
    
    func getLocation(){
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        guard CLLocationManager.locationServicesEnabled() else {
            print("Location services are disabled on your device. In order to use this app, go to " +
                "Settings → Privacy → Location Services and turn location services on.")
            
            return
        }
        
        let authStatus = CLLocationManager.authorizationStatus()
        guard authStatus == .authorizedWhenInUse else {
            switch authStatus {
            case .denied, .restricted:
                print("This app is not authorized to use your location. In order to use this app, " +
                    "go to Settings → GeoExample → Location and select the \"While Using " +
                    "the App\" setting.")
                
            case .notDetermined:
                self.locationManager.requestWhenInUseAuthorization()
                
            default:
                print("Oops! Shouldn't have come this far.")
            }
            return
        }
        
        locationManager.requestLocation()

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
        print("Using last coordinate for weather request")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.last != nil {
            guard let latitude = locations.last?.coordinate.latitude, let longitude = locations.last?.coordinate.longitude else {
                print("Fail converting coordiantion")
                return
            }
            
            print("\(latitude),\(longitude)")
            
            self.coordinate = Coordinate(latitude: latitude, longitude: longitude)
        }
        
    }
}
