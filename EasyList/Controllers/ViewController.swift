//
//  ViewController.swift
//  EasyList
//
//  Created by Student20 on 20/08/2024.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase
import FirebaseAuthUI
import FirebaseGoogleAuthUI
import FirebaseEmailAuthUI



class ViewController: UIViewController, FUIAuthDelegate {
    
    var ref: DatabaseReference!
    
    let providers: [FUIAuthProvider] = [
        FUIGoogleAuth(),
        FUIEmailAuth()
    ]
    
    let authUI = FUIAuth.defaultAuthUI()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
//        initFirebaseAuthentication()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("HERE!!!!")
        Auth.auth().addStateDidChangeListener { (auth, user )in
            if let user = user {
                print("user info = \(user)")
//                self.showUserInfo(user: user)
            } else {
                self.showLoginVC()
            }
        }
    }
    
//    func showUserInfo(user: User) {
//        
//    }
    
    func showLoginVC() {
        let authUI = FUIAuth.defaultAuthUI()
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth(),
            FUIEmailAuth()
        ]
        authUI?.providers = providers
        let authViewController = authUI!.authViewController()
        self.present(authViewController, animated: true, completion: nil)
    }
    
    func initFirebaseAuthentication() {
        self.authUI?.providers = providers

        authUI?.delegate = self
        
        let authViewController = authUI?.authViewController()
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: FirebaseAuth.User?, error: Error?) {
        
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }
        return false
    }
    
}

