//
//  DriverProvider.swift
//  UberClone
//
//  Created by Alan Casas on 15/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import Foundation


protocol DriverProviderProtocol {
    func getAllRiderPetitions(success: @escaping (RiderRequestEntities?) -> Void, failure: @escaping(String?) -> Void)
}

class DriverProvider: DriverProviderProtocol {
    func getAllRiderPetitions (success: @escaping (RiderRequestEntities?) -> Void, failure: @escaping(String?) -> Void) {
        FirebaseManager.shared.getAllRiderPetitions(success: success, failure: failure)
    }
}
