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
    
    let emptyVC = UIViewController()
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
