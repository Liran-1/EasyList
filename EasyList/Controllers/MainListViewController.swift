//
//  MainListViewController.swift
//  EasyList
//
//  Created by Student20 on 21/08/2024.
//

import Foundation
import UIKit

class MainListViewController: UIViewController {
    
    let cellReuseIdentifier = "ListCell"

    var lists: [List] = []
    
    @IBOutlet weak var main_LST_lists: UITableView!
//    let listData = testMainLists
    let listData = ["list1", "list2", "list3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func initList() {
        self.main_LST_lists.register(ListTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        main_LST_lists.delegate = self
        main_LST_lists.dataSource = self
        
        main_LST_lists.reloadData()
        
    }
    @IBAction func addList(_ sender: Any) {
        let alert = UIAlertController(title: "New List", message: "Enter list title", preferredStyle: .alert)
        alert.addTextField{ textField in
            textField.placeholder = "List title"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default)
        if let title = alert.textFields?.first?.text, !title.isEmpty {
            let newList = List(title: title, items: [])
            self.lists.append(newList)
            self.main_LST_lists.reloadData()
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
        
        let cell = main_LST_lists.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ListTableViewCell
//        var cell: UITableViewCell? = self.main_LST_lists.dequeueReusableCell(withIdentifier: cellReuseIdentifier)
        
        let list = lists[indexPath.row]
        cell.main_LBL_listName.text = list.title
//        if(cell == nil) {
//            cell = UITableViewCell(style:UITableViewCell.CellStyle.default, reuseIdentifier: cellReuseIdentifier)
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listVC = storyboard?.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        listVC.list = lists[indexPath.row]
        navigationController?.pushViewController(listVC, animated: true)
    }
}
