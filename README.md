# DGL214-final-project

## Lessons I learnt

- Saving data in iOS with JSON
- How to apply UISearchController to Grocerylist Table view
- How to use API in search engine
- How to develop table view
- How to use UITableViewDiffableDataSource

### Search engine

I was first thinking about how to use API in a search engine. So I looked for how API works or be extracted in the Swift iOS and how to use a search engine to generate this suggested API grocery name results. Then I watched YouTube videos to gain general knowledge about API such as:

- [Getting Data From API in Swift + iOS (Xcode 11 tutorial) - Beginners](https://www.youtube.com/watch?v=sqo844saoC4)
- [Swift Tutorial: Create Your First iOS App in Swift, Xcode 11 (Movie Search App) | Under 30 Minutes](https://www.youtube.com/watch?v=mT3OFcui97k)
- [Swift: News App Search (2021, Xcode 12, Swift 5) - iOS Development for Beginners](https://www.youtube.com/watch?v=_S7r9MCc2ts)
- [UISearchController in Swift 5 (Search Bar, Swift 5 Xcode 12) -2022 - iOS for Beginners](https://www.youtube.com/watch?v=Lb8aJa7J4BI&t=2s)

I also read blogs such as

- [How to make an API call in Swift and Network Requests](https://www.freecodecamp.org/news/how-to-make-your-first-api-call-in-swift/)
- [REST APIs in iOS with Swift (Protocol-Oriented Approach)](https://matteomanferdini.com/network-requests-rest-apis-ios-swift/)

I mostly used _[Swift: News App Search (2021, Xcode 12, Swift 5) - iOS Development for Beginners](https://www.youtube.com/watch?v=_S7r9MCc2ts)_ and _[Building Spotify App in Swift 5 & UIKit - Part 16 - Search API (Xcode 12, 2021, Swift 5) - App](https://www.youtube.com/watch?v=BLm8E2GEhGU)_ for API reference.

Then I found a grocery API that I thought at first to be useful, Spoonacular API. So I wanted to autocomplete simple food names and categorize them. But Spoonacular API’s autocomplete product provides only brand produce and was not categorized. I searched for other grocery APIs but could not find the right public ones.

I wanted to know how to select a result from a search engine and display it on a grocery list. So I researched on it to no avail until I recall that the results on the search engine is displayed as table views. So I used the method and tools used in tableview, especially from _DGL214-Tableview-Tutorial (ReadMe) Github_, to achieve my objective such as

```
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) - to print a result selected from tableview
```

This is where saving data with JSON and Document DirectoryURL in IOS came into place. I have to create a update and save method to update data accordingly.

### TableView

I used instruction from DGL214-Tableview-Tutorial (ReadMe) to achieve a similar result.

## Explantion on how each files functions

### **Folders**

For front view controller of the app, to display two simple folders, an enum Folder file was created. Enum was chosen because an enum (short for enumeration) is a user-defined data type that has a fixed set of related values. It gives us the possibility to model a certain number of options, to make our code type-safe, error free and easy to use.

In the enum Folder, an array stores values of the same `GroceryFolder` type in an ordered list. `GroceryFolder` is the type of values the array is allowed to store. These values are String titles and products of GroceryProducts type array containing names and categories.
Now the app needs to save data in JSON format by encoding and fetching the data by decoding. The process of converting a swift object to a json one is called JSON serialization or encoding and the reverse process i.e. converting json object to swift one is called deserialization or decoding.

iOS makes it very easy to read and write data from device storage, and in fact all apps get a directory for storing any kind of documents we want without worrying about colliding with other apps. This is called the user's documents directory, This uses a new class called `FileManager`, which can provide us with the document directory for the current user.
To create a URL to the file itself we store `URL(fileURLWithPath:relativeTo:)` in foldersJSONURL. The path referred to in the fileURLWithPathparameter is the file’s name excluding any file extension called “Folder”. Next, the relativeTo parameter is the directory to which the file will be saved. This parameter takes a URL which is `FileManager.documentDirectoryURL` extension variable. The json file extension is added using `appendingPathExtension(:)`.

To create the destination directory URL we asked FileManager for a list of URL’s for the documents directory in the user’s home directory (or, in the case of iOS, the app’s home directory). This returns an array of which the first entry will contain the documents directory which is why we specify the first array index of [0] at the end of the statement. This will return a URL object for the documents directory.

`loadFolders()` function uses `Data(contentsOf:)` to read the stored data in `foldersJSONURL`, decode it with `JSONDecoder()` and map the JSON data to `GroceryFolder` model types by making them conform to the Decodable protocol. The return data in `loadFolders()` function is stored in folders array of type GroceryFolder.

`saveAllFolders()` function will encode data in folders variable and write or save data using the write(to:) method that takes two parameters; foldersJSONURL URL to write to and make the write atomic, which means “all at once”.

There is functions to add new folders at the beginning of the array, update folders and delete folders, and add, update and remove groceries in specific folders.

### **Groceryproducts**

GroceryProducts structure is defined in a single file, and the external interface to that structure is automatically made available for other code to use. It defines the grocery list properties to store values and methods to provide functionality.

Adding `Codable` to the inheritance list for GroceryProducts triggers an automatic conformance that satisfies all of the protocol requirements from Encodable and Decodable. We declared a `CodingKeys` enum which is a mapping that Codable can use to convert JSON names into properties for our struct. It conforms to the `CodingKey protocol`, which is what makes this work with the `Codable protocol`.

For its struct, all its stored properties conform to `Hashable`. Hashable is a Swift protocol and it is defined in Apple’s documentation as “a type that provides an integer hash value”. A hashValue is an integer that is the same for any two instances that compare equally.
Any type that conforms to Hashable must also conform to `Equatable`. So its enum type conforms to the Equatable protocol which allows two objects to be compared for equality using the equal-to operator (==) or inequality using the not-equal-to operator (!=).

### **Groceryfolder**

It also uses `Hashable` and `Equatable` protocols. Its structure is defined in a single file, and the external interface to that structure is automatically made available for other code to use. It define the folder list properties to store values and methods to provide functionality. To check only the id property for equality i wrote my own == function and used hash(into:) method which hashes the given components.

### **GroceryFolderViewController**

GroceryFolderViewController class creates the folder tableview using `UITableViewDiffableDataSource`. It provides the behavior you need to manage updates to your table view’s data and UI in a simple, efficient way. This new API is more flexible and declarative than the complicated, brittle and error-prone `UITableViewDataSource` API. Rather than telling the data source how many items to display, you tell it what sections and items to display.

The diffable part of `UITableViewDiffableDataSource` means that whenever you update the items you’re displaying, the tableview will automatically calculate the difference between the updated table and the one previously shown. This will in turn cause the table view to animate the changes, such as updates, insertions and deletions.

UITableViewDiffableDataSource has two generic types: _Section type_ and _item type_. mainSection enum was created for Section type. GroceryFolder data type needs to conforms for diffable data to work to Hashable which it already does. `Hashable` allows the diffable data source to perform updates when folder are added, removed or updated. Conformance to the protocol is needed in order to know whether or not two elements are equal to each other.
`FolderDataSource` class implements the `UITableViewDiffableDataSource`.

With `update(animatingDifferences:)` function, I created a new method that applies a snapshot to the data source. The method takes a Boolean which determines if changes to the data source should animate. `NSDiffableDataSourceSnapshot` stores my sections and items, which the diffable data source references to understand how many sections and cells to display. `NSDiffableDataSourceSnapshot`, like `UITableViewDiffableDataSource`, takes a section type and an item type: _mainSection_ and _GroceryFolder_. I added the .main section and the folder array to the snapshot. `apply(animatingDifferences: )` update and animate the latest snapshot accordingly.

`configureDataSource()` function creates a diffable data source with the specified cell provider, and connects it to the specified table view which is a replacement for `tableView(_:cellForRowAtIndexPath:)`. `viewDidLoad` function display tableview cells, current cells, title and background color immediately when the app loads.

A segue is an object that defines a transition between two view controllers in a storyboard file. `showGroceryList` segue function transition between folder page and its list page.`saveFolderName` function is an unwind segue of the Create button that when selected updates the data source.`unwindToFirstViewController` function is also an unwind segue of the Cancel button that reverse back to parent view controller.

`tableView(_:canEditRowAt:)` asks the data source to verify that the given row is editable. `tableView(_:commit:forRowAt:)` asks the data source to commit the deletion of a specified row in the receiver. It implements a delete method from the Folder.swift and update datasource.

### **APICaller**

This is a class where an API call is the process of a client application submitting a request to an API and that API retrieving the requested data from the external server or program and delivering it back to the client. The `API url` is stored in a variable.
The `search` function takes in the user input as query and completion handler as a parameter. A completion handler in Swift is a function that calls back when a task completes. This is why it is also called a callback function. The query is combined with the `API url`.

To retrieve a info in Swift, I used `URLSession.shared.dataTask()` function. This function takes the URL object as its first argument and a completion handler function as a second one. As per docs, this completion handler function takes the following parameters:

1. data—The data returned by the request.
2. response—Response metadata object that includes the HTTP headers and status code.
3. error—An error object that with information about why the request failed. It returns nil if the request was successful.
   If there is any data, it is decoded from `JSON` format using `APIResponse` class. It is returned as a `GroceryProducts` array type.

### **APIResponse**

I needed to define a custom struct called `APIResponse` that conforms to Codable to store results from our `JSON`, which means it will track the `results` array that contains `title` string, `id` integer.

### **GroceryListViewController**

`GroceryListViewController` class creates the grocerylist tableview using `UITableViewDiffableDataSource`.`UISearchController` communicates with a delegate protocol to let the rest of my app know what the user is doing. By initializing `UISearchController` with a `SearchResultsViewController()` value for vc, I am telling the search controller that i want the search controller to display the results in that view controller instead. By setting `definesPresentationContext` on your view controller to true, I ensured that the search bar doesn’t remain on the screen if the user navigates to another view controller while the `UISearchController` is active.

With an `IBSegueAction`, I created the view controller fully configured and passed it to UIKit for display. The endpoint view controller must have an init that takes the coder argument passed to the `IBSegueAction`. I passed in `GroceryFolder` type argument too that display the grocerylist in a specific folder.

Api have rate limits, so to prevent doing api call every time i type a word, I used
`searchBarSearchButtonClicked(_:)`. It tells the delegate that the search button was tapped and then go ahead and does the query. The input query from the user is searched in `APICaller.shared.search`, and if successful in search it is display on `SearchResultsViewController` table, if not a specific printed error.

### **Searchresultsviewcontrollerdelegate**

It is a protocol that displays search engine results from the API url in tableview form. The tableview is created programmatically.

## Challenged I am still facing

- Making the result I selected on the search engine show on the grocery list in real-time without reopening the app
- Selecting a result from search engine immediately moves to grocery list
- In the results apart from the API suggestion, it includes what the user is writing to be selected in the list.


## Code issues I debugged
- When i click the same search result twice in the search engine and get this error
```
Fatal: supplied item identifiers are not unique. Duplicate identifiers: {(\n    Grocerylist.GroceryProducts(name: \"larissa veronica raspberry cream french roast coffee, raspberry cream, french roast, whole coffee beans, 4 oz, 2-pack, zin: 556846\", categories: false)\n)}
```

i learnt from [Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Fatal: supplied identifiers are not unique'](https://stackoverflow.com/questions/60453022/terminating-app-due-to-uncaught-exception-nsinternalinconsistencyexception) that it can be solved by just adding `Equtable Protocol` to `GroceryProducts`

```
 static func ==(lhs: GroceryProducts, rhs: GroceryProducts) -> Bool {
    return lhs.uuid == rhs.uuid
}

func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
}
```
- I at first couldn't add a new folder using pop-up uiview, but then through [iOS Storyboards: Segues and More](https://www.raywenderlich.com/5055396-ios-storyboards-segues-and-more) I learnt to use unwind segue to achieve what I wanted.

## Reference
- https://www.hackingwithswift.com/books/ios-swiftui/writing-data-to-the-documents-directory

- https://medium.com/@CoreyWDavis/reading-writing-and-deleting-files-in-swift-197e886416b0

- https://www.hackingwithswift.com/articles/119/codable-cheat-sheet

- https://www.hackingwithswift.com/example-code/language/how-to-conform-to-the-equatable-protocol

- https://medium.com/@JoyceMatos/hashable-protocols-in-swift-baf0cabeaebd

- https://stackoverflow.com/questions/61712397/how-to-implement-hashinto-hasher-inout-hasher-for-a-struct

- https://www.raywenderlich.com/5055396-ios-storyboards-segues-and-more

- https://www.raywenderlich.com/9296192-improving-storyboard-segues-with-ibsegueaction

- https://www.raywenderlich.com/4363809-uisearchcontroller-tutorial-getting-started

- https://www.raywenderlich.com/3418439-encoding-and-decoding-in-swift

- https://www.codingem.com/swift-completion-handlers/

- https://developer.apple.com/swift/blog/?id=37
