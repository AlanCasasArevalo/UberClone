//
//  LocationManager.swift
//  UberClone
//
//  Created by Alan Casas on 14/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

enum LocationState {
    case indeterminate
    case disable
    case enable
}

class LocationManager: NSObject {

    static let shared = LocationManager()
    
    var locationManager : CLLocationManager?
    var map: MKMapView?
    var region: MKCoordinateRegion?
    var currentUserLocation = CLLocationCoordinate2D()
    
    func locationReference () {
        //Notificaciones Geofences
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager?.startUpdatingLocation()
        }
        
    }

    static func locationStatus() -> LocationState {
        var state: LocationState = .indeterminate
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                state = .indeterminate
                break
                
            case .restricted, .denied:
                state = .disable
                break
                
            case .authorizedWhenInUse, .authorizedAlways:
                state = .enable
                break
            default:
                ()
            }
        }
        else {
            state = .disable
        }
        
        return state
    }
    
    func setRegion (region: MKCoordinateRegion) {
        self.region = region
    }
    
    func setMap (map: MKMapView) {
        self.map = map
    }
    
    func getLocationFromUserWithMapAndRegion() {
        guard let map = self.map else { return }
        guard let region = self.region else { return }
        map.setRegion(region, animated: true)
    }
    
    func setUserLocationPoint (center: CLLocationCoordinate2D, title: String) {
        guard let map = self.map else { return }
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = title
        map.addAnnotation(annotation)
    }

    func removePreviousAnnotations () {
        guard let map = self.map else { return }
        map.removeAnnotations(map.annotations)
    }
    
    func getCurrentUserLocationUpdated () -> CLLocationCoordinate2D{
        return currentUserLocation
    }
    
}


extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = manager.location?.coordinate {
            let center = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            let region = MKCoordinateRegion(center: center, span: span)
            self.setRegion(region: region)
            getLocationFromUserWithMapAndRegion()
            removePreviousAnnotations()
            self.currentUserLocation = center
            setUserLocationPoint(center: center, title: "Tu estas aqui")
        }
    }
}
