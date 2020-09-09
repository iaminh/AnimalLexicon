//
//  MapPin.swift
//  Lexicon
//
//  Created by Minh on 11/9/16.
//  Copyright © 2016 Lexicon. All rights reserved.
//

import Foundation
import MapKit

class MapPin : NSObject {
    
    let lon: Double
    let lat: Double
    let name : String
    let id : Int
    required init(_ id:Int, lat: Double, lon: Double,  name: String) {
        self.lon = lon
        self.lat = lat
        self.id = id
        self.name = name
    }
}

extension MapPin : MKAnnotation {
    @objc var title : String? {
        return name
    }
    
    @objc var subtitle : String? {
        return ""
    }
    
    @objc var coordinate : CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
}
