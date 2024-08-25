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
import FirebaseAuthUI 

class LoginViewController: UIViewController {
 
    @IBOutlet weak var login_ETXT_email: UITextField!
    @IBOutlet weak var login_ETXT_password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser != nil {
            navigateToMainListScreen()
        }
//        let authVC = authUI.authViewController()
//        authVC.modalPresentationStyle = .fullScreen
//        self.present(authVC, animated: true, completion: nil)
//        self.view.backgroundColor = .systemBlue
    }
    
    func navigateToMainListScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "ListMain") as? MainListViewController {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @IBAction func login_BTN_login(_ sender: Any) {
        guard let email = login_ETXT_email.text, !email.isEmpty else {return}
        guard let password = login_ETXT_password.text, !password.isEmpty else {return}
    
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
            if let error = error {
                print("error occured: \(error.localizedDescription)")
            } else {
                if Auth.auth().currentUser != nil {
                    let user = Auth.auth().currentUser
                    if let user = user {
                        print("uid = \(user.uid)")
                        print("email = \(user.email)")
                    }
                    self.navigateToMainListScreen()
                }
            }
        }
    }
}
