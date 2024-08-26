//
//  MainListViewController.swift
//  EasyList
//
//  Created by Student20 on 21/08/2024.
//

import Foundation
import UIKit

class MainListViewController: UIViewController {
    
    let cellReuseIdentifier = "ListTableViewCell"

    var lists: [List] = []
//    var alertController: UIAlertController?
//    var lists: [List] = [List(title: "Test", items: [])]
    
    @IBOutlet weak var main_LST_lists: UITableView!
    @IBOutlet weak var main_BTN_addNewList: UIButton!
    //    let listData = testMainLists
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        loadListData()
        
        initUI()
    }
    
    func initView() {
        main_LST_lists.delegate = self
        main_LST_lists.dataSource = self
        self.main_LST_lists.register(ListTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    func loadListData() {
        lists = DataManager.shared.loadLists()
        
        
        // Load the data
//        if !UserDefaults().bool(forKey: ConstantsUserDefaults.setup) {
//            UserDefaults().set(true, forKey: ConstantsUserDefaults.setup)
//            UserDefaults().set(0, forKey: ConstantsUserDefaults.numberOfLists)
//        }
        
        main_LST_lists.reloadData()
    }
    
    func initUI() {
        let uiManager = UIManager.shared
        
        uiManager.setTableView(tableView: main_LST_lists)
        uiManager.setButton(button: main_BTN_addNewList)
    }
    
    
    @IBAction func addListFromBar() {
        showAddListAlert()
    }
    
    @IBAction func addList(_ sender: Any) {
        showAddListAlert()
    }
    
    func showAddListAlert() {
        let alertController = UIAlertController(title: "New List", message: "Enter list title", preferredStyle: .alert)
        UIManager.shared.setAlert(alert: alertController)
        alertController.addTextField{ textField in
            textField.placeholder = "List title"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default){ [weak self] _ in
            if let title = alertController.textFields?.first?.text, !title.isEmpty {
                print("Adding new list with title \(title)")
                let newList = List(title: title, items: [])
                self?.lists.append(newList)
                self?.main_LST_lists.reloadData()
                DataManager.shared.saveLists(self?.lists ?? [])
            }
        }
        
        alertController.addAction(addAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowItemSegue" {
            if let destinationVC = segue.destination as? ListViewController,
               let indexPath = main_LST_lists.indexPathForSelectedRow {
                destinationVC.listItems = lists[indexPath.row]
            }
        }
    }
    
}

extension MainListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ListTableViewCell = main_LST_lists.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListTableViewCell
        let list = lists[indexPath.row]
        cell.main_LBL_listName?.text = list.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        main_LST_lists.deselectRow(at: indexPath, animated: true)
        let listVC = storyboard?.instantiateViewController(identifier: "ListItems") as! ListViewController
        listVC.listItems = lists[indexPath.row]
        navigationController?.pushViewController(listVC, animated: true)
    }
}
