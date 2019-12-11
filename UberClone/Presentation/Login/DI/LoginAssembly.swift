//
//  LoginAssembly.swift
//  UberClone
//
//  Created by Alan Casas on 09/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import UIKit

final public class LoginAssembly {
    
    private let riderAssembly: RiderAssemby
    
    init(riderAssembly: RiderAssemby) {
        self.riderAssembly = riderAssembly
    }
    
    final public func viewController () -> UIViewController {
        let viewController = LoginViewController()
        viewController.loginPresenter = presenter(view: viewController)
        return viewController
    }
    
    func presenter (view: LoginViewControllerProtocol) -> LoginPresenterProtocol {
        let presenter = LoginPresenter()
        presenter.loginView = view
        presenter.loginRouter = router(view: view)
        presenter.loginInteractor = interactor()
        return presenter
    }
    
    func router (view: LoginViewControllerProtocol) -> LoginRouterProtocol {
        let router = LoginRouter ()
        router.loginView = view
        return router
    }
    
    func interactor () -> LoginInteractorProtocol {
        let interactor = LoginInteractor()
        interactor.provider = provider()
        return interactor
    }
    
    func provider () -> LoginProviderProtocol {
        let provider = LoginProvider ()
        return provider
    }
        
}




























