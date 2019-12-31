//
//  RiderRequestEntity.swift
//  UberClone
//
//  Created by Alan Casas on 15/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import Foundation

typealias RiderRequestEntities = [RiderRequestEntity]

public struct RiderRequestEntity: Codable {
    let email: String?
    let latitude: Double?
    let longitude: Double?
    var distance: Double?
    var driverLatitude: Double?
    var driverLongitude: Double?
    
}
