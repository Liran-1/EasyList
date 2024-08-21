//
//  ListVIewController.swift
//  EasyList
//
//  Created by Student20 on 21/08/2024.
//

import UIKit
import Foundation

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    @IBOutlet weak var list_LST_items: UITableView!
    
    let listData = testListItem1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func initList() {
        
        list_LST_items.delegate = self
        list_LST_items.dataSource = self
        
        list_LST_items.reloadData()
        
    }
    
}
