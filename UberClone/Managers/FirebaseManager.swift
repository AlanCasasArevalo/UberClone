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
import FirebaseDatabase

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
    
    func getCurrentUserEmail() -> String {
        return Auth.auth().currentUser?.email ?? ""
    }
    
    func setNewRiderIntoDataBaseWithEmailLatitudeAndLongitude (email: String, latitude: Double, longitude: Double) {
        let riderRequestDictionary: [String: Any] = ["email": email, "latitude": latitude, "longitude": longitude]
        Database.database().reference().child("RideRequest").childByAutoId().setValue(riderRequestDictionary)
    }
    
    func cancelUberFromDatabase () {
        let currentEmail = getCurrentUserEmail()
        Database.database().reference().child("RideRequest").queryOrdered(byChild: "email").queryEqual(toValue: currentEmail).observe(.childAdded, with: { (snapShot) in
            snapShot.ref.removeValue()
            Database.database().reference().child("RideRequest").removeAllObservers()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func logout () {
        try? Auth.auth().signOut()
    }
    
    func removeObserver (toggleToChange: inout Bool?) {
        let currentEmail = getCurrentUserEmail()
        Database.database().reference().child("RideRequest").queryOrdered(byChild: "email").queryEqual(toValue: currentEmail).observe(.childAdded, with: { (snapShot) in
            Database.database().reference().child("RideRequest").removeAllObservers()
        }) { (error) in
            print(error.localizedDescription)
        }
        toggleToChange?.toggle()
    }
    
}
