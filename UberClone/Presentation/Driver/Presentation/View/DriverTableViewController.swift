//
//  DriverTableViewController.swift
//  UberClone
//
//  Created by Alan Casas on 15/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import UIKit

protocol DriverTableViewControllerProtocol {
    func dismissFromNavigationController ()
    func reloadDataFromView ()
    func animationForActivityIndicator (animation: Bool)
    func navigationControllerPopToViewController (viewController: UIViewController)
}

class DriverTableViewController: UITableViewController, DriverTableViewControllerProtocol {
    
    var presenter: DriverPresenterProtocol?
    var activityIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creationLogoutButton()
        setActivityIndicatorLayout()
        self.presenter?.viewDidLoad()
        registerCell()
    }
    
    

    func creationActivityInticatorView () {
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator?.color = .lightGray
    }
    
    func setActivityIndicatorLayout () {
        creationActivityInticatorView()
        if (activityIndicator != nil) {
            let x = UIScreen.main.bounds.size.width/2
            let y = UIScreen.main.bounds.size.height/2
            activityIndicator?.center = CGPoint(x: x, y: y)
            self.view.addSubview(activityIndicator!)
        }
    }
    
    func animationForActivityIndicator (animation: Bool) {
        if animation {
            activityIndicator?.startAnimating()
            activityIndicator?.isHidden = false
        } else {
            activityIndicator?.stopAnimating()
            activityIndicator?.isHidden = true
        }
    }
    
    func activityIndicatorStartAnimating () {
        activityIndicator?.startAnimating()
    }
    
    func creationLogoutButton () {
        let logOutButton: UIBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutFromRider))
        self.navigationItem.leftBarButtonItem = logOutButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.viewWillAppear()
    }
    
    @objc func logoutFromRider() {
        self.presenter?.logoutFromDriver()
    }
    
    func dismissFromNavigationController () {
        self.navigationController?.popViewController(animated: true)
    }

    func registerCell () {
        let cell = UINib(nibName: NibName.driverViewCell, bundle: nil)
        self.tableView.register(cell, forCellReuseIdentifier: NibName.driverViewCell)
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.riderEntities?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let entityModel = self.presenter?.riderEntities?[indexPath.row]
        let distance = self.presenter?.getDistanceFromManager(distance: entityModel?.distance ?? 0.0) ?? ""
        let cellModel = DriverViewCellModel(emailLabelText: entityModel?.email ?? "", distanceLabelText: distance, identifier: NibName.driverViewCell)
        let cell = tableView.dequeueReusableCell(withIdentifier: NibName.driverViewCell, for: indexPath) as! DriverViewCell
        cell.setModel(model: cellModel)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60        
    }
    
    func reloadDataFromView () {
        self.tableView.reloadData()
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let entityModel = self.presenter?.riderEntities?[indexPath.row] else { return }
        self.presenter?.navigationToRiderDetailed(riderRequestEntity: entityModel)
    }
    
}

extension DriverTableViewController {
    func navigationControllerPopToViewController (viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

