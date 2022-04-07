//
//  GroceryProducts.swift
//  Grocerylist
//
//  Created by Taiwo Adekanmbi on 2022-03-10.
//

import Foundation

struct GroceryProducts: Hashable{
    let uuid = UUID()
    let name: String
    let categories: Bool

    static func ==(lhs: GroceryProducts, rhs: GroceryProducts) -> Bool {
           return lhs.uuid == rhs.uuid
       }

       func hash(into hasher: inout Hasher) {
           hasher.combine(uuid)
       }
}

extension GroceryProducts: Codable, Equatable{
    enum CodingKeys: String, CodingKey {
        case name
        case categories
    }
}
