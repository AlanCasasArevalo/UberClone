//
//  RiderUserDetailedProvider.swift
//  UberClone
//
//  Created by Alan Casas on 20/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import Foundation

protocol RiderUserDetailedProviderProtocol {
    func acceptPerformRide (emailRequest: String, driverLatitude: Double, driverLongitude: Double, success: @escaping (String?) -> Void, failure: @escaping (String?) -> Void)
    func openMapWithRiderAndDriver (email: String, success: @escaping (String?) -> Void, failure: @escaping (String?) -> Void) 
}

class RiderUserDetailedProvider: RiderUserDetailedProviderProtocol {
    
    func acceptPerformRide (emailRequest: String, driverLatitude: Double, driverLongitude: Double, success: @escaping (String?) -> Void, failure: @escaping (String?) -> Void) {
        FirebaseManager.shared.acceptPerformRide(emailRequest: emailRequest, driverLatitude: driverLatitude, driverLongitude: driverLongitude, success: { (result) in
            success(result)
        }) { (error) in
            failure(error)
        }
    }
    
    func openMapWithRiderAndDriver (email: String, success: @escaping (String?) -> Void, failure: @escaping (String?) -> Void) {
        LocationManager.shared.getReverseGeoCodeLocation(email: email, success: { (result) in
            success(result)
        }) { (error) in
            failure(error)
        }
    }
    
}
