//
//  DriverPresenter.swift
//  UberClone
//
//  Created by Alan Casas on 15/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import Foundation

protocol DriverPresenterProtocol {
    func viewDidLoad ()
    func viewWillAppear ()
    func logoutFromDriver ()
    func getDistanceFromManager (distance: Double) -> String 
    var riderEntities: RiderRequestEntities? { get set }
}

class DriverPresenter: DriverPresenterProtocol {
    var view: DriverTableViewControllerProtocol?
    var router: DriverRouterProtocol?
    var interactor: DriverInteractorProtocol?
    var uberHasBeenCalled: Bool? = false
    var riderEntities: RiderRequestEntities?
    var isActivityIndicatorActive: Bool = true
    
    func viewDidLoad() {
        getAllRiderPetitions()
        reloadtableViewFromPresenter()        
    }
    
    func viewWillAppear() {
        self.view?.animationForActivityIndicator(animation: self.isActivityIndicatorActive)
    }
    
    func logoutFromDriver () {
        self.isActivityIndicatorActive = true
        self.view?.animationForActivityIndicator(animation: self.isActivityIndicatorActive)
        FirebaseManager.shared.logout()
        self.view?.dismissFromNavigationController()
        self.isActivityIndicatorActive = false
        self.view?.animationForActivityIndicator(animation: self.isActivityIndicatorActive)
    }
    
    func getAllRiderPetitions () {
        self.interactor?.getAllRiderPetitions(success: { (requestsEntities) in
            self.riderEntities = requestsEntities
            self.view?.reloadDataFromView()
            self.isActivityIndicatorActive = false
            self.view?.animationForActivityIndicator(animation: self.isActivityIndicatorActive)
        }, failure: { (error) in
            self.isActivityIndicatorActive = false
            self.view?.animationForActivityIndicator(animation: self.isActivityIndicatorActive)
            print(error)
        })
    }
    
    func getDistanceFromManager (distance: Double) -> String {
        let distanceInMeters = distance / 1000
        if distanceInMeters < 1 {
            return String(format: "%.2f", distanceInMeters * 1000) + " m"
        } else {
            return String(format: "%.2f", distanceInMeters) + " Km"
        }
    }
        
    func reloadtableViewFromPresenter () {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { (timer) in
            self.view?.reloadDataFromView()
        }
    }
    
}
