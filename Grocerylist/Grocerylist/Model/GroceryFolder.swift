//
//  GroceryFolder.swift
//  Grocerylist
//
//  Created by Taiwo Adekanmbi on 2022-03-23.
//

import UIKit

struct GroceryFolder: Hashable {
    var id = UUID()
    var title: String = ""
    var products: [GroceryProducts]
    
    init(title: String, products: [GroceryProducts]) {
      self.title = title
      self.products = products
    }

    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
    
    static func == (lhs: GroceryFolder, rhs: GroceryFolder) -> Bool {
      lhs.id == rhs.id
    }
}

extension GroceryFolder: Codable{
    enum CodingKeys: String, CodingKey {
        case title
        case products
    }
}


