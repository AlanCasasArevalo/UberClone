//
//  RiderViewController.swift
//  UberClone
//
//  Created by Alan Casas on 11/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import UIKit
import MapKit

protocol RiderViewControllerProtocol {
    func navigationControllerHideTitle () 
}

class RiderViewController: UIViewController, RiderViewControllerProtocol {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var callAnUberButton: UIButton!
    
    var riderPresenter: RiderPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        let logOutButton: UIBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutFromRider))
        self.navigationItem.rightBarButtonItem = logOutButton
        
        
    }

    @objc func logoutFromRider() {
        self.riderPresenter?.logoutFromRider()
    }
    
    func navigationControllerHideTitle () {
        self.navigationController?.title = ""
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationController?.navigationItem.hidesBackButton = true
    }
    
    @IBAction func callAnUberButton(_ sender: UIButton) {
        self.riderPresenter?.callAnUberButton()
    }

}
