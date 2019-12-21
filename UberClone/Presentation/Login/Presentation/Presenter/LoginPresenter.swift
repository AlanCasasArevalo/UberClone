//
//  LoginPresenter.swift
//  UberClone
//
//  Created by Alan Casas on 09/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import Foundation

protocol LoginPresenterProtocol {
    var isSignUpLogin: Bool { get set }
    var isDriver:Bool? { get set }
    func viewDidLoad ()
    func viewWillAppear ()
    func switchButtonsAndSwitchPresenter (signInButtonTitle: String, registerButtonTitle: String)
    func createNewUser(withEmail: String, password: String, isDriver: Bool)
    func signIn(withEmail: String, password: String)
}

class LoginPresenter: LoginPresenterProtocol {
    var loginView: LoginViewControllerProtocol?
    var loginRouter: LoginRouterProtocol?
    var loginInteractor: LoginInteractorProtocol?
    var isDriver:Bool? = false
    
    var isSignUpLogin: Bool = false
    
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        self.loginView?.showPassengerRolSwitchAndDriver()
    }
    
    func switchButtonsAndSwitchPresenter (signInButtonTitle: String, registerButtonTitle: String) {
        self.loginView?.showPassengerRolSwitchAndDriver()
        let signInButtonTitle = self.setSignInButtonTitle(title: signInButtonTitle)
        let registerButtonTitle = self.setRegisterButtonTitle(title: registerButtonTitle)
        self.loginView?.setSignInButtonTitle(title: signInButtonTitle)
        self.loginView?.setRegisterButtonTitle(title: registerButtonTitle)
    }
    
    func setSignInButtonTitle (title: String) -> String {
        switch title.lowercased() {
        case "Iniciar sesion".lowercased():
            return "Registrarse"
        case "Registrarse".lowercased():
            return "Iniciar sesion"
        default:
            return ""
        }
    }
    
    func setRegisterButtonTitle (title: String) -> String {
        switch title.lowercased() {
        case "Cambia para registrarte".lowercased():
            return "Cambia para Iniciar sesion"
        case "Cambia para Iniciar sesion".lowercased():
            return "Cambia para Registrarte"
        default:
            return ""
        }
    }
    
    func createNewUser(withEmail: String, password: String, isDriver: Bool) {
        loginInteractor?.createNewUser(withEmail: withEmail, password: password, success: { (success) in
            self.loginView?.showAlertWithArguments(alertTitle: "Success", alertMessage: success ?? "", actionTitle: "OK", okCompletionHandler: nil, cancelTitle: nil, cancelCompletionHandler: nil, presentationCompletion: nil)
            var displayName = ""
            if isDriver {
                // Driver
                displayName = "Driver"
            } else {
                // Rider
                displayName = "Rider"
            }
            FirebaseManager.shared.createProfileChangeRequest(displayName: displayName)
            
        }, failure: { (error) in
            self.loginView?.showAlertWithArguments(alertTitle: "Error", alertMessage: error ?? "", actionTitle: "OK", okCompletionHandler: nil, cancelTitle: nil, cancelCompletionHandler: nil, presentationCompletion: nil)
        })
    }
    
    func signIn(withEmail: String, password: String) {

        
        
        self.loginInteractor?.signIn(withEmail: withEmail, password: password, success: { (success) in
            self.loginView?.showAlertWithArguments(alertTitle: "Success", alertMessage: success ?? "", actionTitle: "Ok", okCompletionHandler: { (action) in
                //Aqui se obtiene bien ele nombre
                let displayName = FirebaseManager.shared.getDisplayName()
                if displayName?.lowercased() == "Driver".lowercased() {
                    // Driver
                    self.loginRouter?.navigationToDriverView()
                } else if displayName?.lowercased() == "Rider".lowercased() {
                    // Rider
                    self.loginRouter?.navigationToRiderMap()
                } else {
                    self.loginView?.showAlertWithArguments(alertTitle: "Error", alertMessage: "No se pudo obtener el rol", actionTitle: "OK", okCompletionHandler: nil, cancelTitle: nil, cancelCompletionHandler: nil, presentationCompletion: nil)
                }
            }, cancelTitle: nil, cancelCompletionHandler: nil, presentationCompletion: nil)
        }, failure: { (error) in
            self.loginView?.showAlertWithArguments(alertTitle: "Error", alertMessage: error ?? "", actionTitle: "OK", okCompletionHandler: nil, cancelTitle: nil, cancelCompletionHandler: nil, presentationCompletion: nil)
        })
    }
}






































