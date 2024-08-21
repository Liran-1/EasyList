//
//  MainListViewController.swift
//  EasyList
//
//  Created by Student20 on 21/08/2024.
//

import Foundation
import UIKit

class MainListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    @IBOutlet weak var main_LST_lists: UITableView!
    let listData = testMainLists
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func initList() {
        self.main_LST_lists.register(ListCell.self, forCellReuseIdentifier: "cellList"l)
        
        main_LST_lists.delegate = self
        main_LST_lists.dataSource = self
        
        main_LST_lists.reloadData()
        
    }
    
    
}
