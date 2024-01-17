//
//  Annotation.swift
//  IOSUtils
//
//  Created by The WORLD on 17.01.2024.
//

// MARK: Custom ANNOTATION

import UIKit
import MapKit
import SwiftyJSON

class Annotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var address: String
    var city: String
    var type: String
    var img: UIImage?
    var workHours: JSON
    
    init(title: String, location: CLLocationCoordinate2D, address: String, city: String, type: String, img: UIImage?, workHours: JSON) {
        self.title = title
        self.coordinate = location
        self.address = address
        self.city = city
        self.type = type
        self.subtitle = "\(city) - \(address) - (\(type))"
        self.img = img
        self.workHours = workHours
    }
}

// MARK: USAGE

/// let annotation = Annotation(
///     title: data[i]["name"].stringValue,
///     location: CLLocationCoordinate2D(
///         latitude: data[i]["longitude"].doubleValue,
///         longitude: data[i]["latitude"].doubleValue),
///     address: data[i]["address"].stringValue,
///     city: data[i]["city"].stringValue,
///     type: data[i]["type"].stringValue,
///     img: UIImage(named: data[i]["img"].stringValue),
///     workHours: data[i]["workHours"]
/// )

