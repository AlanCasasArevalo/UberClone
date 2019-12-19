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
    
    func createProfileChangeRequest (displayName: String) {
        let requestProfileChangeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        requestProfileChangeRequest?.displayName = displayName
        requestProfileChangeRequest?.commitChanges(completion: { (error) in
            if error != nil {
                print(error?.localizedDescription)
            }
        })
    }
    
    func getAllRiderPetitions (success: @escaping (RiderRequestEntities?) -> Void, failure: @escaping(String?) -> Void) {
        Database.database().reference().child("RideRequest").observe(.value, with: { (snapshot) in
            let entities = self.transformSnapshotToEntity(snapshot: snapshot)
            success(entities)
        }) { (error) in
            print(error.localizedDescription)
            failure(error.localizedDescription)
        }
        
    }
    
    func transformSnapshotToEntity (snapshot: DataSnapshot) -> RiderRequestEntities {
        var email = ""
        var latitude = 0.0
        var longitude = 0.0
        var riderRequestEntities = RiderRequestEntities()
        let dataDictionary = snapshot.value as? [String: Any]
        for dictionary in dataDictionary ?? [String: Any]() {
            if let riderValues = dictionary.value as? [String: Any] {
                for rider in riderValues {
                    if rider.key == "email" {
                        email = rider.value as? String ?? ""
                    }
                    if rider.key == "latitude" {
                        latitude = rider.value as? Double ?? 0.0
                    }
                    if rider.key == "longitude" {
                        longitude = rider.value as? Double ?? 0.0
                    }
                }
                let entity = RiderRequestEntity(email: email, latitude: latitude, longitude: longitude)
                riderRequestEntities.append(entity)
            }
        }
        
        return riderRequestEntities
    }
    
}
