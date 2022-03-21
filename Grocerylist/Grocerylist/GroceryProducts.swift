//
//  GroceryProducts.swift
//  Grocerylist
//
//  Created by Taiwo Adekanmbi on 2022-03-10.
//

import Foundation

struct GroceryProducts: Hashable{
    let name: String
    let identifer: Int
    let categories: Bool

}

extension GroceryProducts: Codable, Equatable{
    enum CodingKeys: String, CodingKey {
        case name
        case identifer
        case categories
    }
}
