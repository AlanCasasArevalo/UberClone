//
//  RiderAssemby.swift
//  UberClone
//
//  Created by Alan Casas on 11/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import UIKit

final public class RiderAssemby {
    
    final public func viewController () -> UIViewController {
        let viewController = RiderViewController()
        viewController.riderPresenter = presenter(view: viewController)
        return viewController
    }
    
    func presenter (view: RiderViewControllerProtocol) -> RiderPresenterProtocol {
        let presenter = RiderPresenter()
        presenter.view = view
        presenter.router = router(view: view)
        presenter.interactor = interactor()
        return presenter
    }
    
    func router (view: RiderViewControllerProtocol) -> RiderRouterProtocol {
        let router = RiderRouter ()
        router.view = view
        return router
    }
    
    func interactor () -> RiderInteractorProtocol {
        let interactor = RiderInteractor()
        interactor.provider = provider()
        return interactor
    }
    
    func provider () -> RiderProviderProtocol {
        let provider = RiderProvider ()
        return provider
    }
    
}
