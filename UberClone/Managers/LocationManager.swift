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
    var isRiderUserDetailed: Bool = false
    var region: MKCoordinateRegion?
    var currentUserLocation = CLLocationCoordinate2D()
    var riderCurrentLocation = CLLocationCoordinate2D()
    
    var riderEmail = ""
    
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
    
    func removeObserver(toggleToChange: inout Bool?) {
        FirebaseManager.shared.removeObserver(toggleToChange: &toggleToChange)
    }
    
    func getDistanceFromCurrentUserToObjetive(latitude: Double, longitude: Double) -> Double {
        let currentUserLocation = getCurrentUserLocationUpdated()
        let currentLocation = CLLocation(latitude: currentUserLocation.latitude, longitude: currentUserLocation.longitude)
        let objetiveLocation = CLLocation(latitude: latitude, longitude: longitude)
        return currentLocation.distance(from: objetiveLocation)
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
    
    func updateRiderLocation (latitude: Double, longitude: Double) {
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let title = getRiderEmail()
        self.setUserLocationPoint(center: center, title: title)
    }
    
    func setRiderEmail(title: String) {
        riderEmail = title
    }
    
    func getRiderEmail() -> String {
        return riderEmail
    }

    func removePreviousAnnotations () {
        guard let map = self.map else { return }
        map.removeAnnotations(map.annotations)
    }
    
    func getCurrentUserLocationUpdated () -> CLLocationCoordinate2D {
        return currentUserLocation
    }
    
    func setIsRiderUserDetailed (riderUserDetailed: Bool) {
        self.isRiderUserDetailed = riderUserDetailed
    }
    
    func setRiderCurrentLocation (latitude: Double, longitude: Double) {
        riderCurrentLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    func getRiderCurrentLocation () -> CLLocationCoordinate2D {
        return riderCurrentLocation
    }

    func getReverseGeoCodeLocation (email: String, success: @escaping (String?) -> Void, failure: @escaping (String?) -> Void) {
        let requestCLLocation = CLLocation(latitude: riderCurrentLocation.latitude, longitude: riderCurrentLocation.longitude)
        CLGeocoder().reverseGeocodeLocation(requestCLLocation) { (placeMarks, error) in
            if error != nil {
                failure(error?.localizedDescription)
            } else {
                guard let placeMarksDes = placeMarks else { return }
                if placeMarksDes.count > 0 {
                    let placeMark = MKPlacemark(placemark: placeMarksDes.first!)
                    let mapItem = MKMapItem(placemark: placeMark)
                    mapItem.name = email
                    let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                    mapItem.openInMaps(launchOptions: options)
                }
                
            }
        }
        failure("Error al hacer la geolocalizacion inversa")
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = manager.location?.coordinate {
            if !isRiderUserDetailed {
                let center = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
                let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                let region = MKCoordinateRegion(center: center, span: span)
                self.setRegion(region: region)
                getLocationFromUserWithMapAndRegion()
                removePreviousAnnotations()
                self.currentUserLocation = center
                setUserLocationPoint(center: center, title: "Estas aqui")
            } else {
                let center = CLLocationCoordinate2D(latitude: riderCurrentLocation.latitude, longitude: riderCurrentLocation.longitude)
                let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                let region = MKCoordinateRegion(center: center, span: span)
                self.setRegion(region: region)
                getLocationFromUserWithMapAndRegion()
                removePreviousAnnotations()
                riderCurrentLocation = center
                setUserLocationPoint(center: center, title: getRiderEmail())
            }
        }
    }
    
}
