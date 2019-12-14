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
    func setInitialViewValues (callAnUberButtonTitle: String)
    func setMap() 
}

class RiderViewController: UIViewController, RiderViewControllerProtocol {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var callAnUberButton: UIButton!
    
    var riderPresenter: RiderPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.riderPresenter?.viewDidLoad()
        let logOutButton: UIBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutFromRider))
        self.navigationItem.rightBarButtonItem = logOutButton
        setMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.riderPresenter?.viewWillAppear()
    }

    func setInitialViewValues (callAnUberButtonTitle: String) {
        self.callAnUberButton.setTitle(callAnUberButtonTitle, for: .normal)
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
    
    
    func setMap() {
        LocationManager.shared.setMap(map: self.mapView)
    }

}
