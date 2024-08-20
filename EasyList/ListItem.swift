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
}

enum Units: String {
    case g, kg, lbs, ml, lit, oz, tsp, tbsp, cups, pc
}
