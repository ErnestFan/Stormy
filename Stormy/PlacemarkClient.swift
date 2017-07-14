//
//  PlacemarkClient.swift
//  Stormy
//
//  Created by Ernest Fan on 2017-07-13.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
import MapKit

class PlacemarkClient{
    var name: String = ""
    var city: String = ""
    
    
    func getPlacemark(coordinate: Coordinate) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            // Address dictionary
            print(placeMark.addressDictionary as Any)
            
            // Location name
            if let locationName = placeMark.addressDictionary!["Name"] as? NSString {
                self.name = locationName as String
            }
            
            // City
            if let city = placeMark.addressDictionary!["City"] as? NSString {
                self.city = city as String
            }
        })
        
    }
}
