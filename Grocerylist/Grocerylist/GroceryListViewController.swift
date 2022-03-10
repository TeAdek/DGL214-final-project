//
//  GroceryListViewController.swift
//  Grocerylist
//
//  Created by Taiwo Adekanmbi on 2022-03-10.
//

import UIKit

class GroceryListViewController: UITableViewController, UISearchBarDelegate{
    let data = ["Apple", "Orange", "Milk"]
    
    let searchController: UISearchController = {
        let vc = UISearchController(searchResultsController: SearchResultsViewController())
        vc.searchBar.placeholder = "Add to list"
        vc.definesPresentationContext = true
        return vc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSearchBar()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroceryListCell", for: indexPath)
        
        cell.textLabel?.text = data[indexPath.row]
        return cell
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
