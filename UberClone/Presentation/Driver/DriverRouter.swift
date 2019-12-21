//
//  DriverRouter.swift
//  UberClone
//
//  Created by Alan Casas on 15/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import Foundation
protocol DriverRouterProtocol {
    func navigationToDetailRider(riderRequestEntity: RiderRequestEntity)
}

class DriverRouter: DriverRouterProtocol {
    
    var view: DriverTableViewControllerProtocol?
    var riderUserDetailedAssembly: RiderUserDetailedAssembly!
    
    func navigationToDetailRider(riderRequestEntity: RiderRequestEntity) {
        self.view?.navigationControllerPopToViewController(viewController: riderUserDetailedAssembly.viewController(riderRequestEntity: riderRequestEntity))
    }
}
