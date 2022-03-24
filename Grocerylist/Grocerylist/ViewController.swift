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

enum mainSection: String, CaseIterable{
    case main
}

class GroceryFolderViewController: UITableViewController {

    var dataSource: FolderDataSource!
    
    @IBSegueAction func showGroceryList(_ coder: NSCoder) -> GroceryListViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow,
              let folder = dataSource.itemIdentifier(for: indexPath) else{
            fatalError()
        }
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
    newSnapshot.appendSections(mainSection.allCases)
      ////////QUESTION
      let folders = Folders.folders
      newSnapshot.appendItems(folders) //Must in array form
    apply(newSnapshot, animatingDifferences: animatingDifferences)
  }
  
//  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//      indexPath.section == snapshot().indexOfSection(.addNew) ? false : true
//  }
//
//  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//    if editingStyle == .delete {
//      guard let book = self.itemIdentifier(for: indexPath) else { return }
//      Library.delete(book: book)
//      update(sortStyle: currentSortStyle)
//    }
//  }
//
//  override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//      if indexPath.section != snapshot().indexOfSection(.readMe)
//      || currentSortStyle != .readMe {
//      return false
//      } else {
//      return true
//      }
//
//  }
//      override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//          guard
//            sourceIndexPath != destinationIndexPath,
//            sourceIndexPath.section == destinationIndexPath.section,
//            let bookToMove = itemIdentifier(for: sourceIndexPath),
//            let bookAtDestination = itemIdentifier(for: destinationIndexPath)
//          else {
//            apply(snapshot(), animatingDifferences: false)
//            return
//          }
//
//          Library.reorderBooks(bookToMove: bookToMove, bookAtDestination: bookAtDestination)
//          update(sortStyle: currentSortStyle, animatingDifferences: false)
//        }
}


