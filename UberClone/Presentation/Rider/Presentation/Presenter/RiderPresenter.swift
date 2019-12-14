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
    var uberHasBeenCalled: Bool? = false
    
    func viewDidLoad() {
        LocationManager.shared.removeObserver(toggleToChange: &self.uberHasBeenCalled)
    }
    
    func viewWillAppear() {
        self.view?.navigationControllerHideTitle()
        self.view?.setMap()
    }
    
    func logoutFromRider () {
        FirebaseManager.shared.logout()
        self.view?.dismissFromNavigationController()
    }
    
    func getCallAnUberButton () -> String {
        if uberHasBeenCalled ?? false {
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
        if uberHasBeenCalled ?? false {
            FirebaseManager.shared.cancelUberFromDatabase()
        } else {
            let currentUserEmail = FirebaseManager.shared.getCurrentUserEmail()
            let currentUserLocation =  LocationManager.shared.getCurrentUserLocationUpdated()
            FirebaseManager.shared.setNewRiderIntoDataBaseWithEmailLatitudeAndLongitude(email: currentUserEmail, latitude: currentUserLocation.latitude, longitude: currentUserLocation.longitude)
        }
        uberHasBeenCalled?.toggle()
        setInitialViewValues()
    }

}
