//
//  GroceryListViewController.swift
//  Grocerylist
//
//  Created by Taiwo Adekanmbi on 2022-03-10.
//

import UIKit

//enum SortStyle {
//    case name
//    case id
//}

enum Section: String, CaseIterable{
    case categories = "Grocery"
    case finished = "Finished"
}

class GroceryListViewController: UITableViewController, UISearchBarDelegate, SearchResultsViewControllerDelegate{
    
    func logData(_ result: String) {
        print("Query result: \(result)")
        grocery.append(GroceryProducts(name: result, categories: true))
        applySnapshot()
    }
    
//    var dataSource: ProductDataSource!
    var grocery: [GroceryProducts]
//    @IBOutlet var groceryName: UILabel!
    
    // MARK: - Value Types
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
    
    
    // MARK: - Functions
    func configureDataSource() -> ProductDataSource {
                let dataSource = ProductDataSource(tableView: tableView, cellProvider: { (
                    tableView, indexPath, grocery) -> UITableViewCell? in
                  let cell = tableView.dequeueReusableCell(withIdentifier: "GroceryListCell", for: indexPath)
                                        cell.textLabel?.text = grocery.name
                                        return cell
                })
        return dataSource
    }
    
    
    // 1
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
           snapshot.appendSections(Section.allCases)
       
             snapshot.appendItems(grocery)
       
        dataSource.apply(snapshot, animatingDifferences: true)
    }
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        Products.groceries.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "GroceryListCell", for: indexPath)
//        let grocery = Products.groceries[indexPath.row]
//        cell.textLabel?.text = grocery.name
//        return cell
//    }
    //MARK :- Data Source
//    func configureDataSource(){
//        dataSource = ProductDataSource(tableView: tableView){
//            tableView, indexPath, grocery -> UITableViewCell? in
//          let cell = tableView.dequeueReusableCell(withIdentifier: "GroceryListCell", for: indexPath)
//                                cell.textLabel?.text = grocery.name
//                                return cell
//        }
//
//    }
        
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



//class ProductDataSource: UITableViewDiffableDataSource<Section, GroceryProducts> {
//    var newSnapshot = NSDiffableDataSourceSnapshot<Section, GroceryProducts>()
//    func applySnapshot(animatingDifferences: Bool = true) {
//    newSnapshot.appendSections(Section.allCases)
//
//      newSnapshot.appendItems(Products.groceries)
//
//      apply(newSnapshot, animatingDifferences: true)
//
//          }
//
//
//}
//class LibraryDataSource: UITableViewDiffableDataSource<Section, Book> {
//    func update(){
//        var newSnapshot = NSDiffableDataSourceSnapshot<Section, Book>()
//        newSnapshot.appendSections(Section.allCases)
//        let booksByReadMe: [Bool: [Book]] = Dictionary(grouping: Library.books, by: \.readMe)
//class LibraryViewController: UITableViewController {
//            newSnapshot.appendItems(books, toSection: readMe ? .readMe: .finished)
//        }
//        newSnapshot.appendItems([Book.mockBook], toSection: .addNew)
//        dataSource.apply(newSnapshot, animatingDifferences: true)
//        apply(newSnapshot, animatingDifferences: true)
//
//    }
//
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        indexPath.section == snapshot().indexOfSection(.addNew) ? false : true
//    }
//
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete{
//            guard let book = self.itemIdentifier(for: indexPath) else {return}
//            Library.delete(book: book)
//            update()
//        }
//    }
//}
