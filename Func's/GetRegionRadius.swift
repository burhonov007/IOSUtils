//
//  GetRegionRadius.swift
//  IOSUtils
//
//  Created by The WORLD on 17.01.2024.
//

import UIKit

func getRegionRadius(mapView: MKMapView) -> Double {
    let span = mapView.region.span
    let center = mapView.region.center
    
    let location1 = CLLocation(latitude: center.latitude - span.latitudeDelta * 0.5, longitude: center.longitude)
    let location2 = CLLocation(latitude: center.latitude + span.latitudeDelta * 0.5, longitude: center.longitude)
    let location3 = CLLocation(latitude: center.latitude, longitude: center.longitude - span.longitudeDelta * 0.5)
    let location4 = CLLocation(latitude: center.latitude, longitude: center.longitude + span.longitudeDelta * 0.5)
    
    let metersInLatitude = location1.distance(from: location2)
    let metersInLongitude = location3.distance(from: location4)
    
    return (metersInLatitude + metersInLongitude) / 2
}
