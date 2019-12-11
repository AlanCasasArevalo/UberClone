//
//  LoginInteractor.swift
//  UberClone
//
//  Created by Alan Casas on 09/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import Foundation

protocol LoginInteractorProtocol {
    func createNewUser(withEmail: String, password: String, success: @escaping (String?) -> Void, failure: @escaping (String?) -> Void)
    func signIn(withEmail: String, password: String, success: @escaping (String?) -> Void, failure: @escaping (String?) -> Void)
}

class LoginInteractor: LoginInteractorProtocol {
    var provider: LoginProviderProtocol?

    func createNewUser(withEmail: String, password: String, success: @escaping (String?) -> Void, failure: @escaping (String?) -> Void) {
        provider?.createNewUser(withEmail: withEmail, password: password, success: success, failure: failure)
    }
    
    func signIn(withEmail: String, password: String, success: @escaping (String?) -> Void, failure: @escaping (String?) -> Void) {
        provider?.signIn(withEmail: withEmail, password: password, success: success, failure: failure)
    }
}
















































