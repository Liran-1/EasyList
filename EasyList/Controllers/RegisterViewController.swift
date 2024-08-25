//
//  RegisterController.swift
//  EasyList
//
//  Created by Student20 on 25/08/2024.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {
 
    @IBOutlet weak var register_ETXT_email: UITextField!
    @IBOutlet weak var register_ETXT_password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func register_BTN_createAccount(_ sender: Any) {
        guard let email = register_ETXT_email.text else {return}
        guard let password = register_ETXT_password.text else {return}
    
        Auth.auth().createUser(withEmail: email, password: password) { firebaseResult, error in
            if let e = error {
                print("error occured: \(error)")
            } else {
                self.performSegue(withIdentifier: "userLoggedIn", sender: self)
            }
        }
    }
}
