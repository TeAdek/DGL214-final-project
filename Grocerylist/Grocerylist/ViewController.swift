//
//  ViewController.swift
//  Grocerylist
//
//  Created by Taiwo Adekanmbi on 2022-03-09.
//

import UIKit

//Tableview
//Custom cell
//API Caller
//Search grocerylist
//Select gorcerylist suggestion
//When click return enter text in grocerylist
//When suggestion is selected, group grocerylist

enum mainSection: String{
    case main
}

class GroceryFolderViewController: UITableViewController {

    var dataSource: FolderDataSource!
    
    @IBSegueAction func showGroceryList(_ coder: NSCoder) -> GroceryListViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow,
              let folder = dataSource.itemIdentifier(for: indexPath) else{
            fatalError()
        }
        print(indexPath)
        return GroceryListViewController(coder: coder, folder: folder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "GroceryList"
        view.backgroundColor = .systemGreen
        configureDataSource()
        dataSource.update()
        }
    

    @IBAction func saveFolderName(_ segue: UIStoryboardSegue) {
        dataSource.update()
    }
    
    @IBAction func unwindToFirstViewController(_ sender: UIStoryboardSegue) {
         // No code needed, no need to connect the IBAction explicitely
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.update()
    }
    
    //MARK :- Data Source
    func configureDataSource(){
        dataSource = FolderDataSource(tableView: tableView){
            tableView, indexPath, folder-> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "FolderCell", for: indexPath)
            cell.textLabel?.text = folder.title //Actually display the text on table
            return cell
    }
}
}

class FolderDataSource: UITableViewDiffableDataSource<mainSection, GroceryFolder> {
  func update( animatingDifferences: Bool = true) {
    
    var newSnapshot = NSDiffableDataSourceSnapshot<mainSection, GroceryFolder>()
      newSnapshot.appendSections([.main])
      let folders = Folders.folders
      newSnapshot.appendItems(folders) //Must in array form
    apply(newSnapshot, animatingDifferences: animatingDifferences)
  }
  
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        guard let folder = self.itemIdentifier(for: indexPath) else { return }
          Folders.deleteFolder(folder: folder)
          update()
      }
    }
}


