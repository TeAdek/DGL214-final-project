//
//  CreateFolderViewController.swift
//  Grocerylist
//
//  Created by Taiwo Adekanmbi on 2022-03-24.
//

import UIKit

class CreateFolderViewController: UIViewController{
    @IBOutlet var folderName: UITextField!
  
    @IBAction func createFolder(_ sender: UIButton) {
        guard let folderName = folderName.text,
              !folderName.isEmpty
        else {return}
        
        Folders.addNewFolder(folder: GroceryFolder(title: folderName, products:[ GroceryProducts(name: "", categories: true)]))
        print(folderName)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}
