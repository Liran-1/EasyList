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
        FirebaseApp.configure()
        ref = Database.database().reference()
        
        initFirebaseAuthentication()
        // Do any additional setup after loading the view.
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

