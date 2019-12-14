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
    func setInitialViewValues()

}

class RiderPresenter: RiderPresenterProtocol {
    
    var view: RiderViewControllerProtocol?
    var router: RiderRouterProtocol?
    var interactor: RiderInteractorProtocol?
    var uberHasBeenCalled = false
    
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        self.view?.navigationControllerHideTitle()
        self.view?.setMap()
    }
    
    func logoutFromRider () {
        
    }
    
    func getCallAnUberButton () -> String {
        if uberHasBeenCalled {
            return "Cancel Uber"
        } else {
            return "Call an Uber"
        }
    }
    
    func setInitialViewValues() {
        let callAnUberButtonTitle = getCallAnUberButton()
        self.view?.setInitialViewValues(callAnUberButtonTitle: callAnUberButtonTitle)
    }
    
    func callAnUberButton () {
        if uberHasBeenCalled {
            FirebaseManager.shared.cancelUberFromDatabase()
        } else {
            let currentUserEmail = FirebaseManager.shared.getCurrentUserEmail()
            let currentUserLocation =  LocationManager.shared.getCurrentUserLocationUpdated()
            FirebaseManager.shared.setNewRiderIntoDataBaseWithEmailLatitudeAndLongitude(email: currentUserEmail, latitude: currentUserLocation.latitude, longitude: currentUserLocation.longitude)
        }
        uberHasBeenCalled.toggle()
        setInitialViewValues()
    }

}
