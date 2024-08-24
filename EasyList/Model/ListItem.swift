//
//  ListItem.swift
//  EasyList
//
//  Created by Student20 on 20/08/2024.
//

import Foundation

class ListItem:Codable {
    var name: String
    var amount: Double
    var units: Units
    var price: Double
    var completed: Bool
    
    init(name: String, amount: Double, units: Units, price: Double, completed: Bool) {
        self.name = name
        self.amount = amount
        self.units = units
        self.price = price
        self.completed = completed
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case amount
        case units
        case price
        case completed
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.amount = try container.decode(Double.self, forKey: .amount)
        self.units = try container.decode(Units.self, forKey: .units)
        self.price = try container.decode(Double.self, forKey: .price)
        self.completed = try container.decode(Bool.self, forKey: .completed)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(amount, forKey: .amount)
        try container.encode(units, forKey: .units)
        try container.encode(price, forKey: .price)
        try container.encode(completed, forKey: .completed)
    }
    
}

enum Units: String, Codable {
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
