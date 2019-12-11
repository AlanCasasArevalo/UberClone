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
    func viewDidLoad ()
    func viewWillAppear ()
    func switchButtonsAndSwitchPresenter (signInButtonTitle: String, registerButtonTitle: String)
    func createNewUser(withEmail: String, password: String)
    func signIn(withEmail: String, password: String)
}

class LoginPresenter: LoginPresenterProtocol {
    var loginView: LoginViewControllerProtocol?
    var loginRouter: LoginRouterProtocol?
    var loginInteractor: LoginInteractorProtocol?
    
    var isSignUpLogin: Bool = false

    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        
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
    
    func createNewUser(withEmail: String, password: String) {
        loginInteractor?.createNewUser(withEmail: withEmail, password: password, success: { (success) in
            self.loginView?.showAlertWithArguments(alertTitle: "Success", alertMessage: success ?? "", actionTitle: "OK", okCompletionHandler: nil, cancelTitle: nil, cancelCompletionHandler: nil, presentationCompletion: nil)
        }, failure: { (error) in
            self.loginView?.showAlertWithArguments(alertTitle: "Error", alertMessage: error ?? "", actionTitle: "OK", okCompletionHandler: nil, cancelTitle: nil, cancelCompletionHandler: nil, presentationCompletion: nil)
        })
    }
    
    func signIn(withEmail: String, password: String) {
        loginInteractor?.signIn(withEmail: withEmail, password: password, success: { (success) in
            self.loginView?.showAlertWithArguments(alertTitle: "Success", alertMessage: success ?? "", actionTitle: "Ok", okCompletionHandler: { (action) in
                // Navigation to Rider Map
                self.loginRouter?.navigationToRiderMap()
            }, cancelTitle: nil, cancelCompletionHandler: nil, presentationCompletion: nil)
        }, failure: { (error) in
            self.loginView?.showAlertWithArguments(alertTitle: "Error", alertMessage: error ?? "", actionTitle: "OK", okCompletionHandler: nil, cancelTitle: nil, cancelCompletionHandler: nil, presentationCompletion: nil)
        })
    }

}






































