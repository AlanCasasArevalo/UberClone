//
//  DriverRouter.swift
//  UberClone
//
//  Created by Alan Casas on 15/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import Foundation
protocol DriverRouterProtocol {
    func navigationToDetailRider ()
}

class DriverRouter: DriverRouterProtocol {
    var view: DriverTableViewControllerProtocol?

    func navigationToDetailRider() {
        
    }
}
