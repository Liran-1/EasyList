//
//  ListItemTableViewCell.swift
//  EasyList
//
//  Created by Student20 on 23/08/2024.
//

import Foundation
import UIKit

class ListItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var list_IMG_itemCheck: UIImageView!
    @IBOutlet weak var list_LBL_itemName: UILabel!
    @IBOutlet weak var list_LBL_itemAmount: UILabel!
    @IBOutlet weak var list_LBL_itemUnits: UILabel!
    @IBOutlet weak var list_LBL_itemPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        list_IMG_itemCheck.image = UIImage(systemName: "checkmark")
    }
    
    
}
