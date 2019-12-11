//
//  RiderViewController.swift
//  UberClone
//
//  Created by Alan Casas on 11/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import UIKit

protocol RiderViewControllerProtocol {
    
}

class RiderViewController: UIViewController, RiderViewControllerProtocol {

    var riderPresenter: RiderPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
