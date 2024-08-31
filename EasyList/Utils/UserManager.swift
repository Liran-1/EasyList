//
//  UserManager.swift
//  EasyList
//
//  Created by Student20 on 27/08/2024.
//

import Foundation
import FirebaseAuth

class UserManager {
    
    static let shared = UserManager()
    let firebaseAuth = Auth.auth()
    var currentUser: User?
    
    private init() {}
    
    func createUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void){
        self.firebaseAuth.createUser(withEmail: email, password: password) { firebaseResult, error in
            if let error = error {
                print("error occured: \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                if self.firebaseAuth.currentUser != nil {
                    self.currentUser = self.firebaseAuth.currentUser
                    if let user = self.currentUser {
                        print("uid = \(user.uid)")
                        print("email = \(user.email)")
                        completion(.success(()))
                    } //end if
                } // end if
            } // end else
        } // end createUser
    } // end createUser
    
    func loginUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        self.firebaseAuth.signIn(withEmail: email, password: password) { firebaseResult, error in
            if let error = error {
                print("error occured: \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                if self.firebaseAuth.currentUser != nil {
                    self.currentUser = self.firebaseAuth.currentUser
                    if let user = self.currentUser {
                        print("uid = \(user.uid)")
                        print("email = \(user.email)")
                        completion(.success(()))
                    } //end if
                } // end if
            } // end else
        } // end signIn
    } // end loginUser
    
    func logUserOut() -> Bool{
        do {
            try self.firebaseAuth.signOut()
            self.currentUser = firebaseAuth.currentUser
            return true
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        return false
    } // end logUserOut
    
    
}
