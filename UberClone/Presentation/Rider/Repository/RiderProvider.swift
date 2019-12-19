//
//  RiderProvider.swift
//  UberClone
//
//  Created by Alan Casas on 11/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import Foundation

protocol RiderProviderProtocol {
    func setNewRiderIntoDataBaseWithEmailLatitudeAndLongitude(withEmail: String, latitude: Double, longitude: Double, success: @escaping (String?) -> Void, failure: @escaping (String?) -> Void)    
}

class RiderProvider: RiderProviderProtocol {
    
    func setNewRiderIntoDataBaseWithEmailLatitudeAndLongitude(withEmail: String, latitude: Double, longitude: Double, success: @escaping (String?) -> Void, failure: @escaping (String?) -> Void) {
        FirebaseManager.shared.setNewRiderIntoDataBaseWithEmailLatitudeAndLongitude(email: withEmail, latitude: latitude, longitude: longitude)
    }
    
    func signIn(withEmail: String, password: String, success: @escaping (String?) -> Void, failure: @escaping (String?) -> Void) {
        FirebaseManager.shared.signIn(withEmail: withEmail, password: password, success: success, failure: failure)
    }
}
