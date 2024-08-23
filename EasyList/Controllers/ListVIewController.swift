//
//  ListVIewController.swift
//  EasyList
//
//  Created by Student20 on 21/08/2024.
//

import UIKit
import Foundation

class ListViewController: UIViewController{
    
    @IBOutlet weak var list_LST_items: UITableView!
    
    let cellReuseIdentifier = "ItemCell"
    
    var list: List?
    let listItems = testListItem1
//    let listItems = ["item1", "item2", "item3", "item4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initList()
    }
    
    func initList() {
        self.list_LST_items.register(ListItemTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        list_LST_items.delegate = self
        list_LST_items.dataSource = self
        
        list_LST_items.reloadData()
        
    }
    
    @IBAction func addItem(_ sender: Any) {
        let alert = UIAlertController(title: "New Item", message: "Enter item details", preferredStyle: .alert)
        alert.addTextField{ textField in
            textField.placeholder = "Item name"
        }
        alert.addTextField{ textField in
            textField.placeholder = "Amount"
            textField.keyboardType = .decimalPad
        }
        alert.addTextField{ textField in
            textField.placeholder = "Units"
        }
        alert.addTextField{ textField in
            textField.placeholder = "Price"
            textField.keyboardType = .decimalPad
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard var list = self?.list,
                  let itemName = alert.textFields?[0].text,
                  let itemAmountStr = alert.textFields?[1].text, let itemAmount = Double(itemAmountStr),
                  let itemUnits = alert.textFields?[2].text,
                  let itemPriceStr = alert.textFields?[3].text, let itemPrice = Double(itemPriceStr)
            else { return }
            
            let newItem = ListItem(name: itemName, amount: itemAmount, units: Units.pc, price: itemPrice, completed: false)
            list.items.append(newItem)
            self?.list_LST_items.reloadData()
        }
        
        alert.addAction(addAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
}

extension ListViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ListItemTableViewCell
        let item = list?.items[indexPath.row]
        
        cell.list_LBL_itemName.text = item?.name
        cell.list_LBL_itemAmount.text = "\(item?.amount ?? 0)"
        cell.list_LBL_itemUnits.text = item?.name
        cell.list_LBL_itemPrice.text = "\(item?.price ?? 0)"
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let item = list?.items[indexPath.row]
        
    }
}
