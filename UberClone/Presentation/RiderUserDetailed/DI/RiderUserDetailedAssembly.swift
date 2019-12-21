//
//  RiderUserDetailedAssembly.swift
//  UberClone
//
//  Created by Alan Casas on 20/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import UIKit

final public class RiderUserDetailedAssembly {

    final public func viewController (riderRequestEntity: RiderRequestEntity) -> UIViewController {
        let viewController = RiderUserDetailedViewController()
        viewController.presenter = presenter(viewController: viewController, riderRequestEntity: riderRequestEntity)
        return viewController
    }
    
    func presenter(viewController: RiderUserDetailedViewControllerProtocol, riderRequestEntity: RiderRequestEntity) -> RiderUserDetailedPresenterProtocol {
        let presenter = RiderUserDetailedPresenter()
        presenter.view = viewController
        presenter.riderRequestEntity = riderRequestEntity
        presenter.router = router(viewController: viewController)
        presenter.interactor = interactor()
        return presenter
    }
    
    func router (viewController: RiderUserDetailedViewControllerProtocol) -> RiderUserDetailedRouterProtocol {
        let router = RiderUserDetailedRouter()
        router.view = viewController
        return router
    }
    
    func interactor () -> RiderUserDetailedInteractorProtocol  {
        let interactor = RiderUserDetailedInteractor()
        interactor.provider = provider()
        return interactor
    }
    
    func provider () -> RiderUserDetailedProviderProtocol {
        let provider = RiderUserDetailedProvider()
        return provider
    }
}
