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
}

class RiderPresenter: RiderPresenterProtocol {
    
    var view: RiderViewControllerProtocol?
    var router: RiderRouterProtocol?
    var interactor: RiderInteractorProtocol?
    
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        
    }
}
