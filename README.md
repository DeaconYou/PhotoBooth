# PhotoBooth
1. Git clone this project to your local machine, and then use xCode to compile it into your real machine or simulator
2. The name and created timestamp of photos are stored in local sqlite database, and images are stored in local files.
3. DataSourceManager is used as a data interface exposed to outside to save or search data from local database with DatabaseManager and from files with FileManager.
4. ViewModelManager is used in viewControllers and views to get the viewModels for data display instead of directly using DataSourceManager.
5. AsyncImageView is used in the PhotoTableViewCell to fetch the image from local files asynchronously by AsyncOperationManager which uses NSOperationQueue and NSOperation.
6. XCTest is used for Unit Test.
7. Next, I want to add the paging function to the photo list table view, move the huge local image data to the server side and only some image data will be cached in local, add the delete and name-editting function for each photo item on the list view, and use third-party framworks to operate sqlite database and asynchronous image downloading and caching tasks. 
