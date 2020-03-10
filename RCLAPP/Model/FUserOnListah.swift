//
//  FUserOnListah.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 09/03/2020.
//  Copyright © 2020 UCarrot Software & Design. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase
import KRProgressHUD

class FUserOnListah {
    
    let objectId: String
    let createdAt: Date
    
    var email: String
    var firstName: String
    var lastName: String
    var fullName: String
    
    init(_objectId: String, _createdAt: Date, _email: String, _firstName: String, _lastName: String) {
        
        objectId = _objectId
        createdAt = _createdAt
        email = _email
        firstName = _firstName
        lastName = _lastName
        fullName = _firstName + " " + _lastName
        
    }
    
    init(_dictionary: NSDictionary) {
        //constants list
        objectId = _dictionary[kOBJECTID] as! String
        //convert date to string
        createdAt = dateFormatter().date(from: _dictionary[kCREATEDAT] as! String)!
        
        email = _dictionary[kEMAIL] as! String
        firstName = _dictionary[kFIRSTNAME] as! String
        lastName = _dictionary[kLASTNAME] as! String
        fullName = _dictionary[kFULLNAME] as! String
        
    }
    
    //MARK: Returning current user functions
    
    class func currentId() -> String {
        return Auth.auth().currentUser!.uid
    }
    
    class func currentUser () -> FUserOnListah? {
        
        if Auth.auth().currentUser != nil {
            
            if let dictionary = userDefaults.object(forKey: kCURRENTUSER) {
                
                return FUserOnListah.init(_dictionary: dictionary as! NSDictionary)
            }
        }
        
        return nil
        
    }
    
    //MARK: Login and register functions
    
    //call back function
    class func loginUserWith(email: String, password: String, completion: @escaping (_ error: Error?) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (firUser, error) in
            if error != nil {
                completion(error)
                return
            }
            
            //fetch user from firebase
            fetchUser(userId: firUser!.user.uid) { (success) in
                
                if success {
                    
                    print("user loaded successfully")
                }
            }
            completion(error)
        })
    }
    
    //register
    
    //call back function
    class func registerUserWith(email: String, password: String, firstName: String, lastName: String, completion: @escaping (_ error: Error?) -> Void ) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (firUser, error) in
            
            if error != nil {
                
                completion(error)
                return
            }
            
            let fUser = FUserOnListah(_objectId: firUser!.user.uid , _createdAt: Date(), _email: firUser!.user.email!, _firstName: firstName, _lastName: lastName)
            
            //save to user defaults
            saveUserLocally(fUser: fUser)
            //save user in firebase
            saveUserInBackground(fUser: fUser)

            completion(error)
        }
        
    }
    
    //MARK: Logout user
    
    class func logOutCurrentUser(completion: @escaping (_ success: Bool?) -> Void ) {
        
        //delete user from local database
        userDefaults.removeObject(forKey: kCURRENTUSER)
        userDefaults.synchronize()
        
        do {
            try Auth.auth().signOut()
            completion(true)
            
        } catch let error as NSError {
            
            completion(false)
            print("couldnt logout \(error.localizedDescription)")
        }
    }
    
}

//MARK: Save user functions

func saveUserInBackground(fUser: FUserOnListah) {
    
    let ref = firebase.child(kUSER).child(fUser.objectId)
    
    //to save anything in firbase you must convert to NSDictionary
    ref.setValue(userDictionaryFrom(user: fUser))
}

func saveUserLocally(fUser: FUserOnListah) {
    
    UserDefaults.standard.set(userDictionaryFrom(user: fUser), forKey: kCURRENTUSER)
    UserDefaults.standard.synchronize()
}

func userDictionaryFrom(user: FUserOnListah) -> NSDictionary {
    
    let createdAt = dateFormatter().string(from: user.createdAt)
    
    return NSDictionary(objects: [user.objectId, createdAt, user.email, user.firstName, user.lastName, user.fullName], forKeys: [kOBJECTID as NSCopying, kCREATEDAT as NSCopying, kEMAIL as NSCopying, kFIRSTNAME as NSCopying, kLASTNAME as NSCopying, kFULLNAME as NSCopying])
}

//get user from firebase
func fetchUser(userId: String, completion: @escaping (_ success: Bool) -> Void ) {
    //query object id
    firebase.child(kUSER).queryOrdered(byChild: kOBJECTID).queryEqual(toValue: userId).observe(.value, with: {
        snapshot in
        
        if snapshot.exists() {
            
            let user = ((snapshot.value as! NSDictionary).allValues as Array).first! as! NSDictionary
            
            UserDefaults.standard.set(user, forKey: kCURRENTUSER)
            UserDefaults.standard.synchronize()

            completion(true)
            
        } else {
            
            completion(false)
        }
    })
        
}

func resetUserPassword(email: String) {
    
    Auth.auth().sendPasswordReset(withEmail: email) { (error) in
        if error != nil {
            
            KRProgressHUD.showError(withMessage: "Error reseting password")
        } else {
            KRProgressHUD.showError(withMessage: "Password reset email sent!")
        }
    }
}

func cleanupFirebaseObservers() {
    
    firebase.child(kUSER).removeAllObservers()
    firebase.child(kSHOPPINGLIST).removeAllObservers()
    firebase.child(kSHOPPINGITEM).removeAllObservers()
    firebase.child(kGROCERYITEM).removeAllObservers()
}
