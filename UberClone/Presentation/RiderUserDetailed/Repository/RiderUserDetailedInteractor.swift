//
//  RiderUserDetailedInteractor.swift
//  UberClone
//
//  Created by Alan Casas on 20/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import Foundation

protocol RiderUserDetailedInteractorProtocol {
    func acceptPerformRide (emailRequest: String,driverLatitude: Double, driverLongitude: Double , success: @escaping (String?) -> Void, failure: @escaping (String?) -> Void)    
    func openMapWithRiderAndDriver (email: String, success: @escaping (String?) -> Void, failure: @escaping (String?) -> Void) 
}

class RiderUserDetailedInteractor: RiderUserDetailedInteractorProtocol {
    var provider: RiderUserDetailedProviderProtocol?
    
    func acceptPerformRide (emailRequest: String,driverLatitude: Double, driverLongitude: Double , success: @escaping (String?) -> Void, failure: @escaping (String?) -> Void) {
        provider?.acceptPerformRide(emailRequest: emailRequest, driverLatitude: driverLatitude, driverLongitude: driverLongitude, success: { (result) in
            success(result)
        }, failure: { (error) in
            failure(error)
        })
    }
    
    func openMapWithRiderAndDriver (email: String, success: @escaping (String?) -> Void, failure: @escaping (String?) -> Void) {
        provider?.openMapWithRiderAndDriver(email: email, success: { (result) in
            success(result)
        }, failure: { (error) in
            failure(error)
        })
    }
    
}
