//
//  Folders.swift
//  Grocerylist
//
//  Created by Taiwo Adekanmbi on 2022-03-23.
//

import UIKit

enum Folders {
    private static let starterData : [GroceryFolder] = [
        GroceryFolder(title: "Expired", products: [ GroceryProducts(name: "milk", categories: true), GroceryProducts(name: "egg", categories: true) ]),
        GroceryFolder(title: "New", products: [ GroceryProducts(name: "yam", categories: true), GroceryProducts(name: "butter", categories: true) ])
  ]
    
    static var folders: [GroceryFolder] = loadFolders()
    
    private static let foldersJSONURL = URL(fileURLWithPath: "Folder",
                                            relativeTo: FileManager.documentDirectoryURL).appendingPathExtension("json")
    
    
    private static func loadFolders() -> [GroceryFolder] {
          let decoder = JSONDecoder()
    
          guard let foldersData = try? Data(contentsOf: foldersJSONURL) else {
            return starterData
          }
    
          do {
            let folders = try decoder.decode([GroceryFolder].self, from: foldersData)
            return folders.map { groceryFolders in
                GroceryFolder(title: groceryFolders.title, products: groceryFolders.products)
                
            }
    
          } catch let error {
            print(error)
            return starterData
          }
      }
    
      private static func saveAllFolders() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
    
        do {
          let foldersData = try encoder.encode(folders)
          try foldersData.write(to: foldersJSONURL, options: .atomicWrite)
        } catch let error {
          print(error)
        }
      }
    
    //FOLDER METHOD
        static func addNewFolder(folder: GroceryFolder) {
       folders.insert(folder, at: 0)
        saveAllFolders()
      }
    
    
      static func updateFolder(folder: GroceryFolder) {
    
        guard let folderIndex = folders.firstIndex(where: { storedFolder in
          folder.title == storedFolder.title } )
        else {
            print("No folders to update")
            return
        }
    
        folders[folderIndex] = folder
        saveAllFolders()
      }
    
      
      static func deleteFolder(folder: GroceryFolder) {
        guard let folderIndex = folders.firstIndex(where: { storedFolder in
          folder == storedFolder } )
          else { return }
    
        folders.remove(at: folderIndex)
    
        saveAllFolders()
      }
    
    //PRODUCT METHOD
    static func addNewGrocery(grocery: GroceryProducts, index: Int) {
        folders[index].products.insert(grocery, at: 0)
    saveAllFolders()
  }


  static func updateGrocery(grocery: GroceryProducts, index: Int) {

      guard let groceryIndex =  folders[index].products.firstIndex(where: { storedGrocery in
          grocery.name == storedGrocery.name } )
    else {
        print("No grocery to update")
        return
    }

      folders[index].products[groceryIndex] = grocery
    saveAllFolders()
  }

  
  static func deleteGrocery(grocery: GroceryProducts, index: Int) {
      guard let groceryIndex =  folders[index].products.firstIndex(where: { storedGrocery in
          grocery == storedGrocery } )
    else {
        return
      }
      folders[index].products.remove(at: groceryIndex)

    saveAllFolders()
  }
}


extension FileManager {
  static var documentDirectoryURL: URL {
    return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
}

