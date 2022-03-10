//
//  APICaller.swift
//  Grocerylist
//
//  Created by Taiwo Adekanmbi on 2022-03-09.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    struct Constants {
        static let searchGroceryListsURL =  "https://api.spoonacular.com/food/products/search?apiKey=57cb9491b0284d8da6f8727dc4857f1b&query="
    }
    
    private init() {}
    
    // Mark: - Search
    
    public func search(with query: String, completion: @escaping (Result<[SearchResult], Error>) -> Void) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
       let urlString = Constants.searchGroceryListsURL + query
        guard let url = URL(string: urlString) else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){data, _, error in if let error = error {
            completion(.failure(error))
        }
            else if let data = data {
                do{
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    var searchResults: [SearchResult] = []
                    searchResults.append(contentsOf: result.products.compactMap({.product(model: $0)}))
                    
                    completion(.success(searchResults))
                    print("Grocery: \(result.products.count)")
                    print(result)
                }
                catch{
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}
