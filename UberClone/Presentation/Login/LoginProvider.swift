//
//  LoginProvider.swift
//  UberClone
//
//  Created by Alan Casas on 09/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import Foundation

protocol LoginProviderProtocol {
    func createNewUser(withEmail: String, password: String, success: @escaping (String?) -> Void, failure: @escaping (String?) -> Void)
    func signIn(withEmail: String, password: String, success: @escaping (String?) -> Void, failure: @escaping (String?) -> Void)
}

class LoginProvider: LoginProviderProtocol {
    func createNewUser(withEmail: String, password: String, success: @escaping (String?) -> Void, failure: @escaping (String?) -> Void) {
        FirebaseManager.shared.createNewUser(withEmail: withEmail, password: password, success: success, failure: failure)
    }
    
    func signIn(withEmail: String, password: String, success: @escaping (String?) -> Void, failure: @escaping (String?) -> Void) {
        FirebaseManager.shared.signIn(withEmail: withEmail, password: password, success: success, failure: failure)
    }
}
