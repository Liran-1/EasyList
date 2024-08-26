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
    
    @IBOutlet weak var recover_LBL_forgotPassword: UILabel!
    @IBOutlet weak var recover_LBL_forgotPasswordSub: UILabel!
    @IBOutlet weak var recover_ETXT_email: UITextField!
    @IBOutlet weak var recover_ETXT_password: UITextField!
    @IBOutlet weak var recover_BTN_resetPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
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
    
    func initUI() {
        let uiManager = UIManager.shared
        
        uiManager.setTitleLabel(titleLabel: recover_LBL_forgotPassword)
        uiManager.setSubtitleLabel(subtitleLabel: recover_LBL_forgotPasswordSub)
        uiManager.setTextField(textField: recover_ETXT_email)
        uiManager.setTextField(textField: recover_ETXT_password)
        uiManager.setButton(button: recover_BTN_resetPassword)
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
