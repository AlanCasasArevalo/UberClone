//
//  RiderInteractor.swift
//  UberClone
//
//  Created by Alan Casas on 11/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import Foundation

protocol RiderInteractorProtocol {
    func setNewRiderIntoDataBaseWithEmailLatitudeAndLongitude(withEmail: String, latitude: Double, longitude: Double, success: @escaping (String?) -> Void, failure: @escaping (String?) -> Void)
}

class RiderInteractor: RiderInteractorProtocol {
    var provider: RiderProviderProtocol?
    func setNewRiderIntoDataBaseWithEmailLatitudeAndLongitude(withEmail: String, latitude: Double, longitude: Double, success: @escaping (String?) -> Void, failure: @escaping (String?) -> Void) {
        provider?.setNewRiderIntoDataBaseWithEmailLatitudeAndLongitude(withEmail: withEmail, latitude: latitude, longitude: longitude, success: { (successResult) in
            success(successResult)
        }, failure: { (error) in
            failure(error)
        })
    }
}
