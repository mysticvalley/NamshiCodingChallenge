//
//  CoreDataHelper.m
//  CodingChallenge
//
//  Created by TekTak on 6/21/14.
//  Copyright (c) 2014 Namshi. All rights reserved.
//

#import "CoreDataHelper.h"
#import "Product.h"

@implementation CoreDataHelper

+ (instancetype) sharedHelper
{
    static dispatch_once_t pred;
    static CoreDataHelper *whatever = nil;
    dispatch_once(&pred, ^{
        whatever = [[CoreDataHelper alloc] init];
    });
    return whatever;
}

- (void) clearAndResetDatabase {
    
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    NSString *dbStore = SQLITE_FILE;
    NSError *error = nil;
    NSURL *storeURL = [NSPersistentStore MR_urlForStoreName:dbStore];
    
    [MagicalRecord cleanUp];
    
    if([[NSFileManager defaultManager] removeItemAtURL:storeURL error:&error])
        [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:SQLITE_FILE];
    
    else{
        NSLog(@"An error has occurred while deleting %@", dbStore);
        NSLog(@"Error description: %@", error.description);
    }
}

#pragma mark - REST Operations

- (void) saveProductsToCoreDataWithProductsArray:(NSArray *) productsArray {

    NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];
    for (NSDictionary *p in productsArray) {
        Product *product = [Product MR_createInContext:defaultContext];
        product.pid = [NSNumber numberWithInteger:[[p objectForKey:@"id"] integerValue]];
        product.sku = [p objectForKey:@"sku"];
        product.productName = [p objectForKey:@"producName"];
        product.brandName = [p objectForKey:@"brandName"];
        product.image = [p objectForKey:@"image"];
        product.price = [NSNumber numberWithInteger:[[p objectForKey:@"price"] integerValue]];
        product.productPage = [p objectForKey:@"productPage"];
        
        [defaultContext MR_saveToPersistentStoreAndWait];
    }
}

@end
