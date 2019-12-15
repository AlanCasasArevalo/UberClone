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
}

class DriverPresenter: DriverPresenterProtocol {
    
    var view: DriverTableViewControllerProtocol?
    var router: DriverRouterProtocol?
    var interactor: DriverInteractorProtocol?
    var uberHasBeenCalled: Bool? = false
    
    func viewDidLoad() {
    }
    
    func viewWillAppear() {
    }
    
   

}
