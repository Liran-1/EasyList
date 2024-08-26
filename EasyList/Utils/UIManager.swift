//
//  UIManager.swift
//  EasyList
//
//  Created by Student20 on 26/08/2024.
//

import Foundation
import UIKit

class UIManager {
    
    static let shared = UIManager()
    
    private init() {}
    
    func setTitleLabel(titleLabel: UILabel) {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
    }
    
    func setSubtitleLabel(subtitleLabel: UILabel) {
        subtitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        subtitleLabel.textColor = UIColor.darkGray
    }
    
    func setTextField(textField: UITextField) {
//        textField.background = UIColor.white
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
    }
    
    func setTableView(tableView: UITableView) {
        tableView.backgroundColor = UIColor.systemGroupedBackground
        tableView.separatorColor = UIColor.lightGray
        tableView.layer.cornerRadius = 8
    }
    
    func setButton(button: UIButton) {
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 5
    }
    
    func setAlert(alert: UIAlertController) {
        alert.view.layer.cornerRadius = 10
        alert.view.layer.shadowColor = UIColor.black.cgColor
        alert.view.layer.shadowOffset = CGSize(width: 0, height: 2)
        alert.view.layer.shadowOpacity = 0.2
        alert.view.layer.shadowRadius = 4
    }
    
}
