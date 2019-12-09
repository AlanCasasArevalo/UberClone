//
//  LoginViewController.swift
//  UberClone
//
//  Created by Alan Casas on 09/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import UIKit

protocol LoginViewControllerProtocol {
    
}

class LoginViewController: UIViewController, LoginViewControllerProtocol {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rolDriverRiderSwitch: UISwitch!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!

    var loginPresenter: LoginPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func signInButton(_ sender: UIButton) {
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
    }
    
}
