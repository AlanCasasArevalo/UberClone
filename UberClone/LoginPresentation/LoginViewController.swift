//
//  LoginViewController.swift
//  UberClone
//
//  Created by Alan Casas on 09/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import UIKit

protocol LoginViewControllerProtocol {
    func showPassengerRolSwitchAndDriver ()
    func setSignInButtonTitle (title: String)
    func setRegisterButtonTitle (title: String)
}

class LoginViewController: UIViewController, LoginViewControllerProtocol {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rolDriverRiderSwitch: UISwitch!
    @IBOutlet weak var passengerLabel: UILabel!
    @IBOutlet weak var driverLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!

    var loginPresenter: LoginPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loginPresenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loginPresenter?.viewWillAppear()
    }

    @IBAction func signInButton(_ sender: UIButton) {
        if passwordTextField.text == "" || emailTextField.text == "" {
            self.displayAlert(alertTitle: "Empty element", alertMessage: "Password or email could not be empty", actionTitle: "Ok", okCompletionHandler: nil, cancelCompletionHandler: nil, presentationCompletion: nil)
        } else {
            if passwordTextField.text?.count ?? 6 > 7 {
                if self.loginPresenter?.isSignUpLogin ?? false {
                    
                } else {
                    
                }
            }
        }
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        let signInButtonTitle = signInButton.titleLabel?.text ?? ""
        let registerButtonTitle = registerButton.titleLabel?.text ?? ""
        self.loginPresenter?.isSignUpLogin.toggle()
        self.loginPresenter?.switchButtonsAndSwitchPresenter(signInButtonTitle: signInButtonTitle, registerButtonTitle: registerButtonTitle)
    }
    
    func showPassengerRolSwitchAndDriver () {
        let isSignUpLogin = self.loginPresenter?.isSignUpLogin ?? false
        rolDriverRiderSwitch.isHidden = !isSignUpLogin
        passengerLabel.isHidden = !isSignUpLogin
        driverLabel.isHidden = !isSignUpLogin
    }
    
    func setSignInButtonTitle (title: String) {
        self.signInButton.setTitle(title, for: .normal)
    }

    func setRegisterButtonTitle (title: String) {
        self.registerButton.setTitle(title, for: .normal)
    }
}
