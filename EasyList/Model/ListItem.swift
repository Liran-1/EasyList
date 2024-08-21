//
//  ListItem.swift
//  EasyList
//
//  Created by Student20 on 20/08/2024.
//

import Foundation

struct ListItem {
    var name: String
    var amount: Double
    var units: Units
    var price: Double
    var completed: Bool
}

enum Units: String {
    case g, kg, lbs, ml, lit, oz, pc
}

#if DEBUG
let testListItem1 = [
    ListItem(name: "Milk", amount: 2, units: Units.lit, price: 10, completed: false),
    ListItem(name: "Eggs", amount: 12, units: Units.lit, price: 20, completed: false),
    ListItem(name: "Bread", amount: 2, units: Units.pc, price: 10, completed: true),
    ListItem(name: "Cola Can", amount: 7, units: Units.oz, price: 7, completed: false)
]
let testListItem2 = [
    ListItem(name: "Eggs", amount: 6, units: Units.lit, price: 11, completed: false),
    ListItem(name: "Milk", amount: 2, units: Units.lit, price: 10, completed: true),
    ListItem(name: "Cola Can", amount: 1.5, units: Units.lit, price: 10, completed: false),
    ListItem(name: "Bread", amount: 1, units: Units.pc, price: 6, completed: true)
]

#endif
