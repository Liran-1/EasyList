//
//  AddItemViewController.swift
//  EasyList
//
//  Created by Student20 on 24/08/2024.
//

import Foundation
import UIKit

class AddItemViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var addItem_ETXT_itemName: UITextField!
    @IBOutlet weak var addItem_ETXT_ItemAmount: UITextField!
    @IBOutlet weak var addItem_ETXT_ItemUnits: UITextField!
    @IBOutlet weak var addItem_ETXT_ItemPrice: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
    }
    
    func initView() {
        addItem_ETXT_itemName.delegate = self
        addItem_ETXT_ItemAmount.delegate = self
        addItem_ETXT_ItemUnits.delegate = self
        addItem_ETXT_ItemPrice.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveNewItem))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        saveNewItem()
        
        return true
    }
    
    @objc func saveNewItem() {
        guard let itemName = addItem_ETXT_itemName.text, !itemName.isEmpty else { return }
        guard let itemAmount = addItem_ETXT_ItemAmount.text, !itemAmount.isEmpty else { return }
        guard let itemUnits = addItem_ETXT_ItemUnits.text, !itemUnits.isEmpty else { return }
        guard let itemPrice = addItem_ETXT_ItemPrice.text, !itemPrice.isEmpty else { return }
    }
    
}
