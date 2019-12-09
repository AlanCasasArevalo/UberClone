//
//  LoginAssembly.swift
//  UberClone
//
//  Created by Alan Casas on 09/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import UIKit

final public class LoginAssembly {
    
    final public func viewController () -> UIViewController {
        let viewController = LoginViewController()
        return viewController
    }
    
    func presenter () -> LoginPresenter {
        let presenter = LoginPresenter()
        return presenter
    }
    
    func router () -> LoginRouter {
        let router = LoginRouter ()
        return router
    }
    
    func interactor () -> LoginInteractor {
        let interactor = LoginInteractor()
        return interactor
    }
        
}




























