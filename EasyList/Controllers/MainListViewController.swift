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

    var lists: [List] = [List(title: "Test", items: [])]
    
    @IBOutlet weak var main_LST_lists: UITableView!
//    let listData = testMainLists
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        loadListData()
    }
    
    func initView() {
        main_LST_lists.delegate = self
        main_LST_lists.dataSource = self
        self.main_LST_lists.register(ListTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    func loadListData() {
        // Load the data
        main_LST_lists.reloadData()
    }
    
    @IBAction func addListFromBar() {
        
    }
    
    @IBAction func addList(_ sender: Any) {
        let alert = UIAlertController(title: "New List", message: "Enter list title", preferredStyle: .alert)
        alert.addTextField{ textField in
            textField.placeholder = "List title"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default){ [weak self] _ in
            if let title = alert.textFields?.first?.text, !title.isEmpty {
                print("Adding new list with title \(title)")
                let newList = List(title: title, items: [])
                self?.lists.append(newList)
                self?.main_LST_lists.reloadData()
            }
        }
        
        alert.addAction(addAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
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
        listVC.list = lists[indexPath.row]
        navigationController?.pushViewController(listVC, animated: true)
    }
}
