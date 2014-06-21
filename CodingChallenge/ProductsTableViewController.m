//
//  ProductsTableViewController.m
//  CodingChallenge
//
//  Created by TekTak on 6/21/14.
//  Copyright (c) 2014 Namshi. All rights reserved.
//

#import "ProductsTableViewController.h"
#import "Product.h"

@interface ProductsTableViewController ()

@property (nonatomic, strong) NSString *productID;
@property (nonatomic, strong) NSMutableArray *tableData;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"Products";
    self.productID = @"1";
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(saveSampleProductsToCoreData)];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
//    [self.tableView addinfi
    
    /* Pull products from from server using REST API */
    [self pullProductsFromServerFromProductID:self.productID productsCount:50];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    [self.view makeToast:@"5 Sample Products Added" duration:3.0 position:@"Center"];
    
    self.tableData = [[Product MR_findAllInContext:defaultContext] mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - REST Methods

- (void) pullProductsFromServerFromProductID:(NSString *) productID productsCount:(NSUInteger) count {
    
    /* Shows Loading indicator */
    [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeBlack];
    
    NSString *productURLWithParams = [NSString stringWithFormat:@"%@?from=%@&count=%d", PRODUCT_API_URL, productID, count];
    
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
    // Return the number of rows in the section.
    return [self.tableData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"SubtitleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Product *p = [self.tableData objectAtIndex:indexPath.row];
    cell.textLabel.text = p.productName;
    cell.detailTextLabel.text = p.brandName;
    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
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

@end
