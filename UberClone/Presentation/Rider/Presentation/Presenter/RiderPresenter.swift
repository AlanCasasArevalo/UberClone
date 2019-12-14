//
//  RiderPresenter.swift
//  UberClone
//
//  Created by Alan Casas on 11/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import Foundation

protocol RiderPresenterProtocol {
    func viewDidLoad ()
    func viewWillAppear ()
    func logoutFromRider ()
    func callAnUberButton ()
}

class RiderPresenter: RiderPresenterProtocol {
    
    var view: RiderViewControllerProtocol?
    var router: RiderRouterProtocol?
    var interactor: RiderInteractorProtocol?
    
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        self.view?.navigationControllerHideTitle()
        self.view?.setMap()
    }
    
    func logoutFromRider () {
        
    }
    
    func callAnUberButton () {
        let currentUserEmail = FirebaseManager.shared.getCurrentUserEmail()
        let currentUserLocation =  LocationManager.shared.getCurrentUserLocationUpdated()
        FirebaseManager.shared.setNewRiderIntoDataBaseWithEmailLatitudeAndLongitude(email: currentUserEmail, latitude: currentUserLocation.latitude, longitude: currentUserLocation.longitude)
    }

}
