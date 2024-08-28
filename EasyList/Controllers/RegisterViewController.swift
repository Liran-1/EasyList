//
//  RegisterController.swift
//  EasyList
//
//  Created by Student20 on 25/08/2024.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
 
    @IBOutlet weak var register_LBL_signUp: UILabel!
    @IBOutlet weak var register_LBL_signUpSub: UILabel!
    @IBOutlet weak var register_ETXT_email: UITextField!
    @IBOutlet weak var register_ETXT_password: UITextField!
    @IBOutlet weak var register_BTN_createAnAccount: UIButton!
    
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
    
    func validatePassword(password: String) -> Bool{
        if password.count < 8{
            return false
        }
        return true
    }
    
    func initUI() {
        let uiManager = UIManager.shared
        
        uiManager.setTitleLabel(titleLabel: register_LBL_signUp)
        uiManager.setSubtitleLabel(subtitleLabel: register_LBL_signUpSub)
        uiManager.setTextField(textField: register_ETXT_email)
        uiManager.setTextField(textField: register_ETXT_password)
        uiManager.setButton(button: register_BTN_createAnAccount)
    }
    
    @IBAction func register_BTN_createAccount(_ sender: UIButton) {
        guard let email = register_ETXT_email.text, !email.isEmpty else {return}
        guard let password = register_ETXT_password.text, !password.isEmpty else {return}
        if !validatePassword(password: password) { return }
        
        if( UserManager.shared.createUser(email: email, password: password)) {
            self.navigateToMainListScreen()
        }

    }
}
