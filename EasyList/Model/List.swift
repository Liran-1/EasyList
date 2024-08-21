//
//  List.swift
//  EasyList
//
//  Created by Student20 on 20/08/2024.
//

import Foundation

struct List {
    var title: String
    var items: [ListItem]
}

#if DEBUG
let testMainLists = [
    List(title: "First list", items: testListItem1),
    List(title: "Second list", items: testListItem2)
    ]

#endif
