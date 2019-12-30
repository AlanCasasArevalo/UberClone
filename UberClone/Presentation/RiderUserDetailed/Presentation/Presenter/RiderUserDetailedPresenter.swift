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
    func riderAcceptRequest()
    func logout ()
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
        LocationManager.shared.setRiderCurrentLocation(latitude: riderRequestEntity?.latitude ?? 0.0, longitude: riderRequestEntity?.longitude ?? 0.0)
        LocationManager.shared.setRiderEmail(title: riderRequestEntity?.email ?? "")
    }
    
    func viewDidDisappear() {
        LocationManager.shared.setIsRiderUserDetailed(riderUserDetailed: false)
    }

    func riderAcceptRequest() {
        // Update the ride request
        let driverLocation = LocationManager.shared.getCurrentUserLocationUpdated()
        interactor?.acceptPerformRide(emailRequest: riderRequestEntity?.email ?? "", driverLatitude: driverLocation.latitude, driverLongitude: driverLocation.longitude, success: { (result) in
            //Give direction
            self.interactor?.openMapWithRiderAndDriver(email: self.riderRequestEntity?.email ?? "", success: { (result) in
                
            }, failure: { (error) in
                print(error)
            })
        }, failure: { (error) in
            print(error)
        })
    }
    
    func logout () {
        FirebaseManager.shared.logout()
    }

    
}
