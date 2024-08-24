//
//  List.swift
//  EasyList
//
//  Created by Student20 on 20/08/2024.
//

import Foundation

class List:Codable {
    var title: String
    var items: [ListItem]
    
    init(title: String) {
        self.title = title
        self.items = []
    }
    
    init(title: String, items: [ListItem]) {
        self.title = title
        self.items = items
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case items
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.items = try container.decode([ListItem].self, forKey: .items)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(items, forKey: .items)
    }
    
}


#if DEBUG
let testMainLists = [
    List(title: "First list", items: testListItem1),
    List(title: "Second list", items: testListItem2)
]

#endif
