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
    
    func setNewRiderIntoDataBaseWithEmailLatitudeAndLongitude (email: String, latitude: Double, longitude: Double, success: @escaping (String?) -> Void, failure: @escaping (String?) -> Void) {
        
        
        // TODO: Esto no funciona correctamente, si eliminamos email si funciona correctamente
        let riderDictionary: [String: Any] = [
            FirebaseConstants.email: email,
            FirebaseConstants.latitude : latitude,
            FirebaseConstants.longitude : longitude
        ]
        
        Database.database().reference().child(FirebaseConstants.riderEntitiesName).childByAutoId().setValue(riderDictionary) { (error, dataReference) in
            if error != nil {
                failure(error?.localizedDescription)
            } else {
                success("Todo OK")
            }
        }
        
    }
    
    func cancelUberFromDatabase () {
        let currentEmail = getCurrentUserEmail()
        Database.database().reference().child(FirebaseConstants.riderEntitiesName).queryOrdered(byChild: FirebaseConstants.email).queryEqual(toValue: currentEmail).observe(.childAdded, with: { (snapShot) in
            snapShot.ref.removeValue()
            Database.database().reference().child(FirebaseConstants.riderEntitiesName).removeAllObservers()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func logout () {
        try? Auth.auth().signOut()
    }
    
    func removeObserver (toggleToChange: inout Bool?) {
        let currentEmail = getCurrentUserEmail()
        Database.database().reference().child(FirebaseConstants.riderEntitiesName).queryOrdered(byChild: FirebaseConstants.email).queryEqual(toValue: currentEmail).observe(.childAdded, with: { (snapShot) in
            Database.database().reference().child(FirebaseConstants.riderEntitiesName).removeAllObservers()
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
    
    func getDisplayName () -> String? {
        return Auth.auth().currentUser?.displayName
    }
    
    func acceptPerformRide (emailRequest: String, driverLatitude: Double, driverLongitude: Double, success: @escaping (String?) -> Void, failure: @escaping (String?) -> Void) {
        Database.database().reference().child(FirebaseConstants.riderEntitiesName).queryOrdered(byChild: FirebaseConstants.email).queryEqual(toValue: emailRequest).observe(.childAdded, with: { (snapShot) in
            snapShot.ref.updateChildValues([FirebaseConstants.driverLatitude : driverLatitude, FirebaseConstants.driverLongitude: driverLongitude ])
            Database.database().reference().child(FirebaseConstants.riderEntitiesName).removeAllObservers()
            success("Carrera Aceptada")
        }) { (error) in
            print(error.localizedDescription)
            failure(error.localizedDescription)
        }
    }
    
    func getAllRiderPetitions (success: @escaping (RiderRequestEntities?) -> Void, failure: @escaping(String?) -> Void) {
        Database.database().reference().child(FirebaseConstants.riderEntitiesName).observe(.value, with: { (snapshot) in
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
        var driverLatitude = 0.0
        var driverLongitude = 0.0
        var riderRequestEntities = RiderRequestEntities()
        let dataDictionary = snapshot.value as? [String: Any]
        for dictionary in dataDictionary ?? [String: Any]() {
            if let riderValues = dictionary.value as? [String: Any] {
                for rider in riderValues {
                    if rider.key == FirebaseConstants.email {
                        email = rider.value as? String ?? ""
                    }
                    if rider.key == FirebaseConstants.latitude {
                        latitude = rider.value as? Double ?? 0.0
                    }
                    if rider.key == FirebaseConstants.longitude {
                        longitude = rider.value as? Double ?? 0.0
                    }
                    if rider.key == FirebaseConstants.driverLatitude {
                        driverLatitude = rider.value as? Double ?? 0.0
                    }
                    if rider.key == FirebaseConstants.driverLongitude {
                        driverLongitude = rider.value as? Double ?? 0.0
                    }
                }
                let distance = LocationManager.shared.getDistanceFromCurrentUserToObjetive(latitude: latitude, longitude: longitude)
                let entity = RiderRequestEntity(email: email, latitude: latitude, longitude: longitude, distance: distance, driverLatitude: driverLatitude, driverLongitude: driverLongitude)
                riderRequestEntities.append(entity)
            }
        }
        
        return riderRequestEntities.sorted(by: { $0.distance ?? 0.0 < $1.distance ?? 0.0 })
    }
    
}
