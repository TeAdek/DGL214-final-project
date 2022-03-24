//
//  GroceryFolder.swift
//  Grocerylist
//
//  Created by Taiwo Adekanmbi on 2022-03-23.
//

import UIKit

struct GroceryFolder: Hashable {
    let title: String
    static let mockFolder = GroceryFolder(title: "")
}

extension GroceryFolder: Codable{
    enum CodingKeys: String, CodingKey {
        case title
    }
    }
