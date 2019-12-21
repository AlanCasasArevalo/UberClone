//
//  RiderUserDetailedPresenter.swift
//  UberClone
//
//  Created by Alan Casas on 20/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import Foundation

protocol RiderUserDetailedPresenterProtocol {
    func viewDidLoad ()
    func viewWillAppear ()
    func viewDidDisappear()
}

class RiderUserDetailedPresenter: RiderUserDetailedPresenterProtocol {
    
    var view: RiderUserDetailedViewControllerProtocol?
    var router: RiderUserDetailedRouterProtocol?
    var interactor: RiderUserDetailedInteractorProtocol?
    var riderRequestEntity: RiderRequestEntity?

    func viewDidLoad() {
        LocationManager.shared.setIsRiderUserDetailed(riderUserDetailed: true)
    }
    
    func viewWillAppear() {
        LocationManager.shared.setIsRiderUserDetailed(riderUserDetailed: true)
        LocationManager.shared.updateRiderLocation(latitude: riderRequestEntity?.latitude ?? 0.0, longitude: riderRequestEntity?.longitude ?? 0.0)
        LocationManager.shared.setRiderEmail(title: riderRequestEntity?.email ?? "")
    }
    
    func viewDidDisappear() {
        LocationManager.shared.setIsRiderUserDetailed(riderUserDetailed: false)
    }

}
