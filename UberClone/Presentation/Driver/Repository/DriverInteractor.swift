//
//  DriverInteractor.swift
//  UberClone
//
//  Created by Alan Casas on 15/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import Foundation

protocol DriverInteractorProtocol {
    func getAllRiderPetitions(success: @escaping (RiderRequestEntities?) -> Void, failure: @escaping(String?) -> Void)
}

class DriverInteractor: DriverInteractorProtocol {
    var provider: DriverProviderProtocol?
    
    func getAllRiderPetitions(success: @escaping (RiderRequestEntities?) -> Void, failure: @escaping(String?) -> Void) {
        provider?.getAllRiderPetitions(success: success, failure: failure)
    }
    
}
