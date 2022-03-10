//
//  GroceryListViewController.swift
//  Grocerylist
//
//  Created by Taiwo Adekanmbi on 2022-03-10.
//

import UIKit

class GroceryListViewController: UITableViewController, UISearchBarDelegate{
    let data = ["Apple", "Orange", "Milk"]
    
    private let searchVC = UISearchController(searchResultsController: nil)
    
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
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        print(text)
    }
}
