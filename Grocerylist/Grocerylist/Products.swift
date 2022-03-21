//
//  Product.swift
//  Grocerylist
//
//  Created by Taiwo Adekanmbi on 2022-03-15.
//

import UIKit

enum Products {
    private static let starterData = [
        GroceryProducts(name: "Apple", identifer: 12345, categories: true),
        GroceryProducts(name: "Orange", identifer: 234567, categories: false)
    ]
    
    static var groceries: [GroceryProducts] = loadGroceries()
    
    private static let productsJSONURL = URL(fileURLWithPath: "Groceries",
                                            relativeTo: FileManager.documentDirectoryURL).appendingPathExtension("json")
    
    
    /// This method loads all existing data from the `groceryJSONURL`, if available. If not, it will fall back to using `starterData`
    /// - Returns: Returns an array of books, loaded from a JSON file
    private static func loadGroceries() -> [GroceryProducts] {
        let decoder = JSONDecoder()

        guard let productsData = try? Data(contentsOf: productsJSONURL) else {
          return starterData
        }

        do {
          let products = try decoder.decode([GroceryProducts].self, from: productsData)
          return products.map { GroceryList in
            GroceryProducts(
              name: GroceryList.name,
              identifer: GroceryList.identifer,
              categories: GroceryList.categories
            )
          }
          
        } catch let error {
          print(error)
          return starterData
        }
    }
    
    private static func saveAllGroceryLists() {
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted

      do {
        let productsData = try encoder.encode(groceries)
        try productsData.write(to: productsJSONURL, options: .atomicWrite)
      } catch let error {
        print(error)
      }
    }
    
    static func addNew(grocery: GroceryProducts) {
        groceries.insert(grocery, at: 0)
        saveAllGroceryLists()
    }
    
    static func update(grocery: GroceryProducts) {
      guard let productIndex = groceries.firstIndex(where: { storedProduct in
          grocery.name == storedProduct.name } )
      else {
          print("No grocerylist to update")
          return
      }
      
      groceries[productIndex] = grocery
      saveAllGroceryLists()
    }

    static func delete(grocery: GroceryProducts) {
        guard let productIndex = groceries.firstIndex(where: { storedProduct in
            grocery.name == storedProduct.name } )
        else {
            return
        }
        
      groceries.remove(at: productIndex)
      
      saveAllGroceryLists()
    }
    
//    static func reorderGroceryList(productToMove: GroceryProducts, productAtDestination: GroceryProducts) {
//        let destinationIndex = Products.groceries.firstIndex(of: productAtDestination)
//      groceries.removeAll(where: { $0.name == productToMove.name })
//        groceries.insert(productToMove, at: destinationIndex)
//      saveAllGroceryLists()
//    }
    
}

extension FileManager {
  static var documentDirectoryURL: URL {
    return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
}

//    @IBAction func addMercury(_ sender: UIButton) {
//        self.data.insert("mercury", at: 0)
//
//        self.tableView.performBatchUpdates({
//            self.tableView.insertRows(at: [IndexPath(row: 0,
//                                                       section: 0)],
//                                      with: .automatic)
//        }, completion: nil)
//    }
    
