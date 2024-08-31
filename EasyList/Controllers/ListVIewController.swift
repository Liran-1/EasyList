//
//  ListVIewController.swift
//  EasyList
//
//  Created by Student20 on 21/08/2024.
//

import UIKit
import Foundation

class ListViewController: UIViewController{
    
    @IBOutlet weak var list_LBL_listName: UILabel!
    @IBOutlet weak var list_LST_items: UITableView!
    @IBOutlet weak var list_BTN_addNewItem: UIButton!
    
    let cellReuseIdentifier = "ListItemTableViewCell"
    let addItemVCIdentifier = "ListAddItem"
    
    var listItems: List? // The selected list
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        initView()
        initUI()
    }
    
    func initView() {
        self.list_LST_items.register(ListItemTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        list_LST_items.delegate = self
        list_LST_items.dataSource = self
        
        self.title = listItems?.title
        list_LST_items.reloadData()
    }
    
    func initUI() {
        let uiManager = UIManager.shared
        
        uiManager.setTitleLabel(titleLabel: list_LBL_listName)
        uiManager.setTableView(tableView: list_LST_items)
        uiManager.setButton(button: list_BTN_addNewItem)
    }
    
    @IBAction func didTapAdd() {
        let addItemVC = storyboard?.instantiateViewController(identifier: addItemVCIdentifier) as! AddItemViewController
        addItemVC.title = "New List Item"
        navigationController?.pushViewController(addItemVC, animated: true)
    }
    
    @IBAction func addItem(_ sender: Any) {
        showAddItemAlert()
    }
    
    func showAddItemAlert() {
        let alertController = UIAlertController(title: "New Item", message: "Enter item details", preferredStyle: .alert)
        
        UIManager.shared.setAlert(alert: alertController)

        
        alertController.addTextField{ textField in
            textField.placeholder = "Item name"
        }
        alertController.addTextField{ textField in
            textField.placeholder = "Amount"
            textField.keyboardType = .decimalPad
        }

        alertController.addTextField{ textField in
            textField.placeholder = "Units (g\\kg\\lbs\\ml\\lit\\oz\\pc)"
        }
        alertController.addTextField{ textField in
            textField.placeholder = "Price"
            textField.keyboardType = .decimalPad
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let self = self,
                  let list = self.listItems,
                  let itemName = alertController.textFields?[0].text, !itemName.isEmpty,
                  let itemAmountStr = alertController.textFields?[1].text, !itemAmountStr.isEmpty,
                  let itemAmount = Double(itemAmountStr),
                  let itemUnitsStr = alertController.textFields?[2].text, !itemUnitsStr.isEmpty,
                  let itemUnits = Units(rawValue: itemUnitsStr),
                  let itemPriceStr = alertController.textFields?[3].text, !itemPriceStr.isEmpty,
                  let itemPrice = Double(itemPriceStr)
            else { return }
//            let itemName = alertController.textFields?[0].text
            
//            let itemAmountStr = alertController.textFields?[1].text
//            let itemAmount = Double(itemAmountStr)
            
            
//            let itemUnitsStr = alertController.textFields?[2].text
//            guard let itemUnits = Units(rawValue: itemUnitsStr) else {return}
            
//            let itemPriceStr = alertController.textFields?[3].text
//            let itemPrice = Double(itemPriceStr)
            
            let newItem = ListItem(name: itemName, amount: itemAmount, units: itemUnits, price: itemPrice, completed: false)
            list.items.append(newItem)
            DataManager.shared.addListItem(listItem: newItem, list: list) { result in
                switch result {
                case .success:
                    print("ItemList successfully saved!")
                case .failure(let error):
                    print("Error saving item to list: \(error.localizedDescription)")
                }
            }
            self.list_LST_items.reloadData()
            updateSavedData(updatedList: list)
        }
        
        alertController.addAction(addAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
    }
    
    func createUnitsPicker(alertController: UIAlertController) -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        return pickerView
    }
    
    func updateSavedData(updatedList: List) {
        var allLists = DataManager.shared.loadLists()
        if let index = allLists.firstIndex(where: {$0.title == listItems?.title}) {
            allLists[index] = updatedList
            DataManager.shared.saveLists(allLists)
        }
    }
}

extension ListViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Units.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Units.allCases[row].rawValue
    }
    
    
}

extension ListViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listItems?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListItemTableViewCell = list_LST_items.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ListItemTableViewCell
        if let item = listItems?.items[indexPath.row]{
            cell.list_LBL_itemName.text = item.name
            cell.list_LBL_itemAmount.text = "\(item.amount)"
            cell.list_LBL_itemUnits.text = item.units.rawValue
            cell.list_LBL_itemPrice.text = "\(item.price)"
            cell.list_IMG_itemCheck.image = UIImage(named: item.completed ? "icon_checked" : "icon_unchecked")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        list_LST_items.deselectRow(at: indexPath, animated: true)
        
        let item = listItems?.items[indexPath.row]
        item?.completed.toggle()
        
        list_LST_items.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete Item") { [weak self] (action, view, completionHandler) in
            self?.handleDelete(at: indexPath)
            completionHandler(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    private func handleDelete(at indexPath: IndexPath) {
        // Remove the item from the list
        listItems?.items.remove(at: indexPath.row)
        
        // Animate the deletion
        list_LST_items.deleteRows(at: [indexPath], with: .automatic)
    }
}
