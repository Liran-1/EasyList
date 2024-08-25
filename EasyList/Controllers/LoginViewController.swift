//
//  LoginViewController.swift
//  EasyList
//
//  Created by Student20 on 25/08/2024.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
 
    @IBOutlet weak var login_ETXT_email: UITextField!
    @IBOutlet weak var login_ETXT_password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBlue
    }
    
    @IBAction func login_BTN_login(_ sender: Any) {
        guard let email = login_ETXT_email.text else {return}
        guard let password = login_ETXT_password.text else {return}
    
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
            if let e = error {
                print("error occured: \(error)")
            } else {
                self.performSegue(withIdentifier: "userLoggedIn", sender: self)
            }
        }
    }
}
