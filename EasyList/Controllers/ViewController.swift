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


class ViewController: UIViewController {

    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        initFirebaseAuthentication()
        // Do any additional setup after loading the view.
    }
    
    func initFirebaseAuthentication() {
        
    }


}

