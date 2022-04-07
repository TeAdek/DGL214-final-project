//
//  APIResponse.swift
//  Grocerylist
//
//  Created by Taiwo Adekanmbi on 2022-03-09.
//

import Foundation

struct APIResponse: Codable{
    let results: [Product]
}

struct Product: Codable{
    let id: Int
    let title: String
}

