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
        guard let itemName = addItem_ETXT_itemName.text, !itemName.isEmpty,
              let itemAmountStr = addItem_ETXT_ItemAmount.text, !itemAmountStr.isEmpty,
              let itemAmount = Double(itemAmountStr),
              let itemUnitsStr = addItem_ETXT_ItemUnits.text, !itemUnitsStr.isEmpty,
              let itemUnits = Units(rawValue: itemUnitsStr),
              let itemPriceStr = addItem_ETXT_ItemPrice.text, !itemPriceStr.isEmpty,
              let itemPrice = Double(itemPriceStr)
        else {return}
        
        let newItem = ListItem(name: itemName, amount: itemAmount, units: itemUnits, price: itemPrice)
        
//        let itemAmount = Double(itemAmountStr) ?? 0.0
//        guard let itemUnits = Units(rawValue: itemUnitsStr) else {return}
//        let itemPrice = Double(itemPriceStr) ?? 0.0
        
        
        
//        let newItem = ListItem(name: itemName, amount: itemAmount, units: itemUnits, price: itemPrice, completed: false)
//        list.items.append(newItem)
//        self.list_LST_items.reloadData()
//        DataManager.shared.saveLists(DataManager.shared.loadLists())
    }
    
}
