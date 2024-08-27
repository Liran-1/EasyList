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
 
    @IBOutlet weak var login_LBL_signIn: UILabel!
    @IBOutlet weak var login_LBL_signInSub: UILabel!
    @IBOutlet weak var login_ETXT_email: UITextField!
    @IBOutlet weak var login_ETXT_password: UITextField!
    @IBOutlet weak var login_BTN_signIn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser != nil {
            navigateToMainListScreen()
        }
        initUI()
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
    
    func initUI() {
        let uiManager = UIManager.shared
        
        uiManager.setTitleLabel(titleLabel: login_LBL_signIn)
        uiManager.setSubtitleLabel(subtitleLabel: login_LBL_signInSub)
        uiManager.setTextField(textField: login_ETXT_email)
        uiManager.setTextField(textField: login_ETXT_password)
        uiManager.setButton(button: login_BTN_signIn)
    }
    
    @IBAction func login_BTN_login(_ sender: Any) {
        guard let email = login_ETXT_email.text, !email.isEmpty else {return}
        guard let password = login_ETXT_password.text, !password.isEmpty else {return}
    
        if (UserManager.shared.loginUser(email: email, password: password)) {
            self.navigateToMainListScreen()
        }
        
    }
}
