//
//  ProductsTableViewController.m
//  CodingChallenge
//
//  Created by TekTak on 6/21/14.
//  Copyright (c) 2014 Namshi. All rights reserved.
//

#import <SVPullToRefresh/SVPullToRefresh.h>
#import "WebViewController.h"
#import "ProductsTableViewController.h"
#import "Product.h"

@interface ProductsTableViewController ()

@property (nonatomic, assign) NSInteger productID;
@property (nonatomic, strong) NSMutableArray *tableData;
@property (nonatomic, strong) NSMutableArray *searchResults;

@property (nonatomic, assign) NSInteger lastFetchedProductID;

@end

@implementation ProductsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"Products";
    
    // Initial Product Id
    self.productID = 1;
    
    UIBarButtonItem *clearItem = [[UIBarButtonItem alloc] initWithTitle:@"Clear DB" style:UIBarButtonItemStylePlain target:self action:@selector(clearCache:)];
    self.navigationItem.leftBarButtonItem = clearItem;

    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(saveSampleProductsToCoreData)];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
    
    // Loading previously Saved data from local iPhone database
    NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];
    self.tableData = [[Product MR_findAllSortedBy:@"productName" ascending:YES inContext:defaultContext] mutableCopy];
    
    if ( self.tableData > 0 ) {
        __weak ProductsTableViewController *weakSelf = self;
        
        // setup infinite scrolling
        [self.tableView addInfiniteScrollingWithActionHandler:^{
            [weakSelf insertRowAtBottom];
        }];
    }
    /* Pull products from from server using REST API */
    // Get 20 records startingw withing pid = self.productID
    
#warning - below Method method implements logic to pull products from server and save it to local iphone db
//    [self pullProductsFromServerFromProductID:self.productID productsCount:20];
}

- (void) clearCache:(id) sender {
    
    // Reset everything here
    [[CoreDataHelper sharedHelper] clearAndResetDatabase];
    
    [self.view makeToast:@"Core data flushed! Add + button to add sample data with infinite scrolling" duration:5.0 position:TOAST_POSITION_CENTER];
    self.tableData = [[Product MR_findAll] mutableCopy];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* Not used for this demo
- (void)insertRowAtTop {
    __weak ProductsTableViewController *weakSelf = self;
    
    // delaying so that we can see Waiting Spinner in UI
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf.tableView beginUpdates];
        
        NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];
        Product *newInsertingProduct = [Product MR_createInContext:defaultContext];
        newInsertingProduct.brandName = [NSString stringWithFormat:@"Loaded BrandName %d", arc4random()%100];
        newInsertingProduct.productName = [NSString stringWithFormat:@"Loaded ProductName %d", arc4random()%100];
        [defaultContext MR_saveToPersistentStoreAndWait];

        [weakSelf.tableData addObject:newInsertingProduct];        
        [weakSelf.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
        [weakSelf.tableView endUpdates];
        [weakSelf.tableView.pullToRefreshView stopAnimating];
    });
} */

- (void)insertRowAtBottom {
    __weak ProductsTableViewController *weakSelf = self;
    
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [weakSelf.tableView beginUpdates];

#warning - Uncomment below code to pull the data from server and save it to coredata Logic and comment sample one record adding code
        // The new product items with the server url can be fetched here and save fetched data to database and add it to tableview
//        [self pullProductsFromServerFromProductID:self.lastFetchedProductID+1 productsCount:20];
        
#warning - Adding only one record into the core data and loading it in table
        NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];
        Product *newInsertingProduct = [Product MR_createInContext:defaultContext];
        newInsertingProduct.brandName = [NSString stringWithFormat:@"Loaded BrandName %d", arc4random()%100];
        newInsertingProduct.productName = [NSString stringWithFormat:@"Loaded ProductName %d", arc4random()%100];
        [defaultContext MR_saveToPersistentStoreAndWait];
        [weakSelf.tableData addObject:newInsertingProduct];

        [weakSelf.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:weakSelf.tableData.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
        [weakSelf.tableView endUpdates];
        [weakSelf.tableView.infiniteScrollingView stopAnimating];
    });
}

- (void) saveSampleProductsToCoreData {
    
    NSArray *productName = @[@"Jeans Pant", @"Futsal Shoe", @"Top T-Shirt", @"Short Skirts", @"One Piece Wear"];
    NSArray *brandName = @[@"John Player", @"Nike", @"ASOS", @"John Player", @"Kathmandu"];
    
    NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];
    
    // Save 5 products
    for (int i = 0 ; i < 5; i++ ) {
        
        Product *p = [Product MR_createInContext:defaultContext];
        p.pid = [NSNumber numberWithInt:i];
        p.sku = [NSString stringWithFormat:@"sku-%d", i];
        p.productName = productName[i];
        p.brandName = brandName[i];
        p.price = [NSNumber numberWithInt:250 * arc4random() % 5];
        p.image = @"http://namshi.com/image_url";
        p.productPage = @"http://namshi.com/product_url";
        
        [defaultContext MR_saveToPersistentStoreAndWait];
    }
    
    [self.view makeToast:@"+5 Sample Products Added" duration:TOAST_DURATION position:TOAST_POSITION_CENTER];
    
    self.tableData = [[Product MR_findAllInContext:defaultContext] mutableCopy];
    [self.tableView reloadData];
    
    __weak ProductsTableViewController *weakSelf = self;
    
    // setup infinite scrolling
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf insertRowAtBottom];
    }];
}

#pragma mark - REST Methods

- (void) pullProductsFromServerFromProductID:(NSInteger) productID productsCount:(NSUInteger) count {
    
    /* Shows Loading indicator */
    [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeBlack];
    
    NSString *productURLWithParams = [NSString stringWithFormat:@"%@?from=%d&count=%d", PRODUCT_API_URL, productID, count];
    
    // Considering API consumes GET Verb
    [[NetworkHelper sharedHelper] GETRequestWithURL:productURLWithParams completionBlock:^(MKNetworkOperation *completedOperation) {
        
        NSError *error = nil;
        NSDictionary *productsJSON = [NSJSONSerialization JSONObjectWithData:completedOperation.responseData options:NSJSONReadingAllowFragments error:&error];
        
        if ( error ) {
            UI_ALERT_OK(@"JSON Error", @"Error while parsing response from server!");
            return;
        }
/*  Lets consider the response with json are in follow format
 
    {  "response" : [
             
            {
                 id: <int>,
                 sku: <string>,
                 productName: <string>,
                 brandName: <string>,
                 image: <url>
                 price: <int>
                 productPage: <url>
            },
     
            {
                 id: <int>,
                 sku: <string>,
                 productName: <string>,
                 brandName: <string>,
                 image: <url>
                 price: <int>
                 productPage: <url>

            }   ... and so on.
        ]
    }
*/
        NSArray *products = productsJSON[@"response"];
        [[CoreDataHelper sharedHelper] saveProductsToCoreDataWithProductsArray:products];
        
        NSDictionary *lastFetchedProduct = [products lastObject];

        // Saving last fetched product Id for loading next page products when user scrolls down
        self.lastFetchedProductID = [[lastFetchedProduct  objectForKey:@"id"] integerValue];
        self.tableData = [[Product MR_findAll] mutableCopy];
        [self.tableView reloadData];
        
        /* Dismiss Loading Indicator */
        [SVProgressHUD dismiss];
        
    } errorBlock:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        UI_ALERT_OK(@"Error", error.localizedDescription);
        /* Dismiss Loading Indicator */
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [self.searchResults count];
    }
    // Return the number of rows in the section.
    return [self.tableData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell= nil;
    NSString *cellIdentifier = @"NormalCell";
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }
    }
    else {
        cellIdentifier = @"SubtitleCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    }
    // Configure the cell...
    Product *p = [self.tableData objectAtIndex:indexPath.row];
    cell.textLabel.text = p.productName;
    cell.detailTextLabel.text = p.brandName;

    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Product *p = [self.tableData objectAtIndex:indexPath.row];
    WebViewController *webViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([WebViewController class])];
    webViewController.title = p.productName;
    [self.navigationController pushViewController:webViewController animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - Content Filtering

- (void)updateFilteredContentForName:(NSString *)searchName searchScope:(NSInteger) scope
{
    [self.searchResults removeAllObjects]; // First clear the filtered array.
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"productName contains[c] %@ || brandName contains[c] %@", searchName, searchName];
    NSArray *tempArray = [self.tableData filteredArrayUsingPredicate:predicate];
    self.searchResults = [NSMutableArray arrayWithArray:tempArray];
}

#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSInteger selectedScopeButtonIndex = [self.searchDisplayController.searchBar selectedScopeButtonIndex];
    [self updateFilteredContentForName:searchString searchScope:selectedScopeButtonIndex];
    
    // Return YES to cause the search result table view  to be reloaded.
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    NSString *searchString = [self.searchDisplayController.searchBar text];
    
    [self updateFilteredContentForName:searchString searchScope:searchOption];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"Search Bar Clicked");
}

@end
