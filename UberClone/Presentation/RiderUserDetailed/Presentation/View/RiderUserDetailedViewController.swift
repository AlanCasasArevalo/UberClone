//
//  RiderUserDetailedViewController.swift
//  UberClone
//
//  Created by Alan Casas on 20/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import UIKit
import MapKit

protocol RiderUserDetailedViewControllerProtocol {
}

class RiderUserDetailedViewController: UIViewController, RiderUserDetailedViewControllerProtocol {

    @IBOutlet weak var riderMapview: MKMapView!
    @IBOutlet weak var riderAcceptRequestButton: UIButton!
    
    var presenter: RiderUserDetailedPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        self.presenter?.viewDidLoad()
        let logOutButton: UIBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        self.navigationItem.rightBarButtonItem = logOutButton
        setMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.viewWillAppear()
        setupRiderAcceptRequestButton()        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.presenter?.viewDidDisappear()

    }
    
    @IBAction func riderAcceptRequestButtonTouched(_ sender: UIButton) {
        self.presenter?.riderAcceptRequest()
    }
    
    func setupRiderAcceptRequestButton () {
        self.riderAcceptRequestButton.setTitle("Aceptar carrera", for: .normal)
    }
    
    @objc func logout() {
        self.presenter?.logout()
    }
    
    func setMap() {
        LocationManager.shared.setMap(map: self.riderMapview)
    }
    
}
