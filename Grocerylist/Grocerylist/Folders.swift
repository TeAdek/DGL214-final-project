//
//  Folders.swift
//  Grocerylist
//
//  Created by Taiwo Adekanmbi on 2022-03-23.
//

import UIKit

// 1
//class Folders: Hashable {
//  var id = UUID()
//  // 2
//  var title: String
//  // 3
//  var products: [GroceryProducts]
//
//  init(title: String, products: [GroceryProducts]) {
//    self.title = title
//    self.products = products
//  }
//  // 4
//  func hash(into hasher: inout Hasher) {
//    hasher.combine(id)
//  }
//
//  static func == (lhs: Folders, rhs: Folders) -> Bool {
//    lhs.id == rhs.id
//  }
//}

enum Folders {
    private static let starterData : [GroceryFolder] = [
        GroceryFolder(title: "Expired", products: [ GroceryProducts(name: "milk", identifer: 12344, categories: true), GroceryProducts(name: "egg", identifer: 1234467, categories: true)
                                          
    ]),  GroceryFolder(title: "New", products: [ GroceryProducts(name: "yam", identifer: 123448, categories: true), GroceryProducts(name: "butter", identifer: 12344867, categories: true) ])
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
    
    
        static func addNew(folder: GroceryFolder) {
       folders.insert(folder, at: 0)
        saveAllFolders()
      }
    
    
      static func update(folder: GroceryFolder) {
    
        guard let folderIndex = folders.firstIndex(where: { storedFolder in
          folder.title == storedFolder.title } )
        else {
            print("No book to update")
            return
        }
    
        folders[folderIndex] = folder
        saveAllFolders()
      }
    
      
      static func delete(folder: GroceryFolder) {
        guard let folderIndex = folders.firstIndex(where: { storedFolder in
          folder == storedFolder } )
          else { return }
    
        folders.remove(at: folderIndex)
    
        saveAllFolders()
      }
    
}
//enum Folders {
//  private static let starterData = [
// GroceryFolder(title: "Expired"),
// GroceryFolder(title: "New")
//  ]
//
//  static var folders: [GroceryFolder] = loadFolders()
//
//  private static let foldersJSONURL = URL(fileURLWithPath: "Folder",
//                                relativeTo: FileManager.documentDirectoryURL).appendingPathExtension("json")
//
//
//  private static func loadFolders() -> [GroceryFolder] {
//      let decoder = JSONDecoder()
//
//      guard let foldersData = try? Data(contentsOf: foldersJSONURL) else {
//        return starterData
//      }
//
//      do {
//        let folders = try decoder.decode([GroceryFolder].self, from: foldersData)
//        return folders.map { groceryFolders in
//            GroceryFolder(title: groceryFolders.title)
//        }
//
//      } catch let error {
//        print(error)
//        return starterData
//      }
//  }
//
//  private static func saveAllFolders() {
//    let encoder = JSONEncoder()
//    encoder.outputFormatting = .prettyPrinted
//
//    do {
//      let foldersData = try encoder.encode(folders)
//      try foldersData.write(to: foldersJSONURL, options: .atomicWrite)
//    } catch let error {
//      print(error)
//    }
//  }
//
//
//    static func addNew(folder: GroceryFolder) {
//   folders.insert(folder, at: 0)
//    saveAllFolders()
//  }
//
//
//  static func update(folder: GroceryFolder) {
//
//    guard let folderIndex = folders.firstIndex(where: { storedFolder in
//      folder.title == storedFolder.title } )
//    else {
//        print("No book to update")
//        return
//    }
//
//    folders[folderIndex] = folder
//    saveAllFolders()
//  }
//
//  /// Removes a book from the `books` array.
//  /// - Parameter book: The book to be deleted from the library.
//  static func delete(folder: GroceryFolder) {
//    guard let folderIndex = folders.firstIndex(where: { storedFolder in
//      folder == storedFolder } )
//      else { return }
//
//    folders.remove(at: folderIndex)
//
//    saveAllFolders()
//  }
//
//}

//extension FileManager {
//  static var documentDirectoryURL: URL {
//    return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
//  }
//}

