//
//  MainListViewController.swift
//  EasyList
//
//  Created by Student20 on 21/08/2024.
//

import Foundation
import UIKit
import FirebaseAuth

class MainListViewController: UIViewController {
    
    let cellReuseIdentifier = "ListTableViewCell"

    var lists: [List] = []
    
    @IBOutlet weak var main_LBL_title: UILabel!
    @IBOutlet weak var main_LST_lists: UITableView!
    @IBOutlet weak var main_BTN_addNewList: UIButton!
    //    let listData = testMainLists
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        loadListData()
        
        initUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        if self.isMovingFromParent {
            UserManager.shared.logUserOut()
        }
    }
    
    
    func navigateToLoginScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "Login") as? LoginViewController {
            self.navigationController?.pushViewController(viewController, animated: true)
        } // end if
    } // end navigateToLoginScreen
    
    func initView() {
        main_LST_lists.delegate = self
        main_LST_lists.dataSource = self
        self.main_LST_lists.register(ListTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    func loadListData() {
//        lists = DataManager.shared.loadLists()
        DataManager.shared.loadListsFromDB() { result in
            switch result {
            case .success(let lists):
                self.lists = lists
                print("Loaded lists: \(lists)")
                self.main_LST_lists.reloadData()
            case .failure(let error):
                print("Error loading lists: \(error.localizedDescription)")
            }
            
        }
    } // end loadListData
    
    func initUI() {
        let uiManager = UIManager.shared
        
        uiManager.setTitleLabel(titleLabel: main_LBL_title)
        uiManager.setTableView(tableView: main_LST_lists)
        uiManager.setButton(button: main_BTN_addNewList)
    } // end initUI
    
    
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
                DataManager.shared.addList(list: newList) { result in
                    switch result {
                    case .success():
                        print("List successfully saved!")
                    case .failure(let error):
                        print("Error saving list: \(error.localizedDescription)")
                    }}
//                DataManager.shared.saveListsToDB(self?.lists ?? [])
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete List") { [weak self] (action, view, completionHandler) in
            self?.handleDelete(at: indexPath)
            completionHandler(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    private func handleDelete(at indexPath: IndexPath) {
        
        DataManager.shared.deleteList(list: lists[indexPath.row]) { result in
            switch result {
            case .success():
                print("List removed successfully")
                self.main_LST_lists.reloadData()
            case .failure(let error):
                print("Error removing list: \(error.localizedDescription)")
                return
            }
        }

        // Remove the item from the list
        lists.remove(at: indexPath.row)
        
        // Animate the deletion
        main_LST_lists.deleteRows(at: [indexPath], with: .automatic)
    }
}
