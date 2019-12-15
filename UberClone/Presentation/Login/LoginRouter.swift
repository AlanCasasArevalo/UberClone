//
//  LoginRouter.swift
//  UberClone
//
//  Created by Alan Casas on 09/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import Foundation
protocol LoginRouterProtocol {
    func navigationToRiderMap ()
    func navigationToDriverView ()
}

class LoginRouter: LoginRouterProtocol {
    
    var loginView: LoginViewControllerProtocol?
    var riderAssembly: RiderAssemby!
    var driverAssembly: DriverAssemby!

    func navigationToRiderMap () {
        self.loginView?.navigationControllerPopToViewController(viewController: self.riderAssembly.viewController())
    }
    
    func navigationToDriverView () {
        self.loginView?.navigationControllerPopToViewController(viewController: self.driverAssembly.viewController())
    }
    
}
















































