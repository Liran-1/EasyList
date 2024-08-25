//
//  RegisterController.swift
//  EasyList
//
//  Created by Student20 on 25/08/2024.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
 
    @IBOutlet weak var register_ETXT_email: UITextField!
    @IBOutlet weak var register_ETXT_password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func navigateToMainListScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "ListMain") as? MainListViewController {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func validatePassword(password: String) -> Bool{
        if password.count < 8{
            return false
        }
        return true
    }
    
    @IBAction func register_BTN_createAccount(_ sender: UIButton) {
        guard let email = register_ETXT_email.text, !email.isEmpty else {return}
        guard let password = register_ETXT_password.text, !password.isEmpty else {return}
        if validatePassword(password: password) { return }
    
        Auth.auth().createUser(withEmail: email, password: password) { firebaseResult, error in
            if let error = error {
                print("error occured: \(error.localizedDescription)")
            } else {
                self.navigateToMainListScreen()
            }
        }
    }
}
