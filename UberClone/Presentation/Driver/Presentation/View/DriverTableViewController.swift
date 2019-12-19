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
        let cellModel = DriverViewCellModel(emailLabelText: entityModel?.email ?? "", latitudeLabelText: entityModel?.latitude ?? 0.0, longitudeLabelText: entityModel?.longitude ?? 0.0, identifier: NibName.driverViewCell)

        let cell = tableView.dequeueReusableCell(withIdentifier: NibName.driverViewCell, for: indexPath) as! DriverViewCell

        cell.setModel(model: cellModel)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func reloadDataFromView () {
        self.tableView.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
