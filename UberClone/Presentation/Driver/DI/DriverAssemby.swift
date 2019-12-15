//
//  DriverAssemby.swift
//  UberClone
//
//  Created by Alan Casas on 15/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import UIKit

final public class DriverAssemby {

    final public func viewController () -> UIViewController {
        let viewController = DriverTableViewController()
        viewController.presenter = presenter(viewController: viewController)
        return viewController
    }
    
    func presenter(viewController: DriverTableViewControllerProtocol) -> DriverPresenterProtocol {
        let presenter = DriverPresenter()
        presenter.view = viewController
        presenter.router = router(viewController: viewController)
        presenter.interactor = interactor()
        return presenter
    }
    
    func router (viewController: DriverTableViewControllerProtocol) -> DriverRouterProtocol {
        let router = DriverRouter()
        router.view = viewController
        return router
    }
    
    func interactor () -> DriverInteractorProtocol  {
        let interactor = DriverInteractor()
        interactor.provider = provider()
        return interactor
    }
    
    func provider () -> DriverProviderProtocol {
        let provider = DriverProvider()
        return provider
    }
}
