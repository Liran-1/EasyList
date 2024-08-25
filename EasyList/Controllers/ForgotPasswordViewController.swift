//
//  ForgotPasswordViewController.swift
//  EasyList
//
//  Created by Student20 on 25/08/2024.
//

import Foundation
import UIKit
import FirebaseAuth

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var recover_ETXT_email: UITextField!
    @IBOutlet weak var recover_ETXT_password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func navigateToMainListScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "ListMain") as? MainListViewController {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func navigateToLoginScreen() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func recover_BTN_reset(_ sender: UIButton) {
        guard let email = recover_ETXT_email.text, !email.isEmpty else {return}
        guard let password = recover_ETXT_password.text, !password.isEmpty else {return}
        
        Auth.auth().currentUser?.updatePassword(to: password){ error in
            if let error = error {
                print("error occured: \(error.localizedDescription)")
            } else {
                self.navigateToMainListScreen()
            }
        }
    }
}
