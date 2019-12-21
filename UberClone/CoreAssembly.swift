//
//  CoreAssembly.swift
//  UberClone
//
//  Created by Alan Casas on 09/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import UIKit

final public class CoreAssembly {
    
    private let navigationController: UINavigationController
    
    private(set) lazy var loginAssembly = LoginAssembly(riderAssembly: riderAssembly, driverAssembly: driverAssembly)
    private(set) lazy var riderAssembly = RiderAssemby()
    private(set) lazy var driverAssembly = DriverAssemby(riderUserDetailedAssembly: riderUserDetailedAssembly)
    private(set) lazy var riderUserDetailedAssembly = RiderUserDetailedAssembly()
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
