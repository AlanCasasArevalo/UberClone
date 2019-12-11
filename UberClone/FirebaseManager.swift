//
//  FirebaseManager.swift
//  UberClone
//
//  Created by Alan Casas on 09/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    func startConfiguration () {
        FirebaseApp.configure()
    }
    
    func createNewUser(withEmail: String, password: String, success: @escaping (String?) -> Void, failure: @escaping (String?) -> Void) {
        Auth.auth().createUser(withEmail: withEmail, password: password) { (user, error) in
            if error != nil {
                failure(error?.localizedDescription)
            } else {
                success("Sign up Success")
            }
        }
    }
    
    func signIn(withEmail: String, password: String, success: @escaping (String?) -> Void, failure: @escaping (String?) -> Void) {
        Auth.auth().signIn(withEmail: withEmail, password: password) { (user, error) in
            if error != nil {
                failure(error?.localizedDescription)
            } else {
                success("Log in Success")
            }
        }
    }
}
