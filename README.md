# DGL214-final-project
### Lessons I learnt
- Saving data in iOS with JSON
- How to apply UISearchController to Grocerylist Table view
- How to use API in search engine
- How to develop table view

## Search engine
I was first thinking about how to use API in a search engine. So I looked for how API works or be extracted in the Swift iOS and how to use a search engine to generate this suggested API grocery name results. Then I watched YouTube videos to gain general knowledge about API such as:
- Getting Data From API in Swift + iOS (Xcode 11 tutorial) - Beginners, 
- Getting Data From API in Swift + iOS (Xcode 11 tutorial) - Beginners, 
- Swift Tutorial: Create Your First iOS App in Swift, Xcode 11 (Movie Search App) | Under 30 Minutes, 
- Swift: News App Search (2021, Xcode 12, Swift 5) - iOS Development for Beginners
- UISearchController in Swift 5 (Search Bar, Swift 5 Xcode 12) -2022 - iOS for Beginners

I also read blogs such as 
- How to make an API call in Swift and Network Requests
- REST APIs in iOS with Swift (Protocol-Oriented Approach)

I mostly used *Swift: News App Search (2021, Xcode 12, Swift 5) - iOS Development for Beginners* and *Building Spotify App in Swift 5 & UIKit - Part 16 - Search API (Xcode 12, 2021, Swift 5) - App* for API reference. 

Then I found a grocery API that I thought at first to be useful, Spoonacular API. So I wanted to autocomplete simple food names and categorize them. But Spoonacular API’s autocomplete product provides only brand produce and was not categorized. I searched for other grocery APIs but could not find the right public ones.

I wanted to know how to select a result from a search engine and display it on a grocery list. So I researched on it to no avail until I recall that the results on the search engine is displayed as table views. So I used the method and tools used in tableview, especially from *DGL214-Tableview-Tutorial (ReadMe) Github*, to achieve my objective such as 
``` 
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) - to print a result selected from tableview
```
This is where saving data with JSON and Document DirectoryURL in IOS came into place. I have to create a update and save method to update data accordingly.

## TableView
I used instruction from DGL214-Tableview-Tutorial (ReadMe) to achieve a similar result.

### Challenged I am facing
- Making the result I selected on the search engine show on the grocery list in real-time without reopening the app
- Finding the right API to display my work progress that is public and not limited in use
- Showing an indication that the result in the search engine was chosen
- Selecting a result from search engine immediately moves to grocery list
- In the results apart from the API suggestion, it includes what the user is writing to be selected in the list