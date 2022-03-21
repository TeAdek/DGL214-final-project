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
        static let searchGroceryListsURL = "https://api.spoonacular.com/food/products/suggest?apiKey=57cb9491b0284d8da6f8727dc4857f1b&number=5&query="
       
    }
    
    private init() {}
    
    // Mark: - Search
    
    public func search(with query: String, completion: @escaping (Result<[GroceryProducts], Error>) -> Void) {
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
                    //QUESTION???
                    let searchResults: [GroceryProducts] = result.results.compactMap({GroceryProducts( name: $0.title, identifer: $0.id, categories: true)})
                    completion(.success(searchResults))
                    print("Grocery: \(result.results.count)")
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
