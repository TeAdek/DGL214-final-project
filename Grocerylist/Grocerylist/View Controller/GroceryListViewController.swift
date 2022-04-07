//
//  GroceryListViewController.swift
//  Grocerylist
//
//  Created by Taiwo Adekanmbi on 2022-03-10.
//

import UIKit


enum Section: String, CaseIterable{
    case categories = "Grocery"
    case finished = "Finished"
}

class GroceryListViewController: UITableViewController, UISearchBarDelegate, SearchResultsViewControllerDelegate{
    func logData(_ result: String) {
        print("Query result: \(result)")
        applySnapshot()
    }
    
    var grocery: [GroceryProducts]

    typealias ProductDataSource = UITableViewDiffableDataSource<Section, GroceryProducts>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, GroceryProducts>
    private lazy var dataSource = configureDataSource()
    
    let searchController: UISearchController = {
        let vc = UISearchController(searchResultsController: SearchResultsViewController())
        vc.searchBar.placeholder = "Add to list"
        vc.definesPresentationContext = true
        return vc
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSearchBar()
        applySnapshot(animatingDifferences: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applySnapshot(animatingDifferences: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    required init?(coder: NSCoder) {
        fatalError("This should never be called!")
    }

    init?(coder: NSCoder, folder: GroceryFolder){
        self.grocery = folder.products
            super.init(coder: coder)
        }
    
    
    func configureDataSource() -> ProductDataSource {
                let dataSource = ProductDataSource(tableView: tableView, cellProvider: { (
                    tableView, indexPath, grocery) -> UITableViewCell? in
                  let cell = tableView.dequeueReusableCell(withIdentifier: "GroceryListCell", for: indexPath)
                                        cell.textLabel?.text = grocery.name
                                        return cell
                })
        return dataSource
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
           snapshot.appendSections(Section.allCases)
       
             snapshot.appendItems(grocery)
       
        dataSource.apply(snapshot, animatingDifferences: true)
        
    }
        
    private func createSearchBar(){
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let resultsController = searchController.searchResultsController as? SearchResultsViewController,
        let query = searchBar.text, !query.isEmpty else {
            return
        }
        resultsController.delegate = self
        APICaller.shared.search(with: query){ result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    resultsController.update(with: results)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        }
        print(query)
    }
}

//class GrocerylistDataSource: UITableViewDiffableDataSource<mainSection, GroceryProducts> {
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//      if editingStyle == .delete {
//        guard let groceryfolder = self.itemIdentifier(for: indexPath) else { return }
//     
//          let snapshot = self.snapshot()
//          print("INDEX: \(groceryfolder)")
//          Folders.deleteGrocery(grocery: groceryfolder, index: 1)
//          apply(snapshot)
//      }
//    }
//}




