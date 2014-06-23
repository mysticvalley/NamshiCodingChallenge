//
//  CoreDataHelper.h
//  CodingChallenge
//
//  Created by TekTak on 6/21/14.
//  Copyright (c) 2014 Namshi. All rights reserved.
//

/*
 *  This is helper class which will contain all the coredata related activities like saving to store, deleting from store. This class will be able to communicate with coredata via methods. "Magical Records" pod is used for simplifying core data operation.
 */
#import <Foundation/Foundation.h>

@interface CoreDataHelper : NSObject

+ (instancetype) sharedHelper;

#pragma mark - REST Operations

- (void) saveProductsToCoreDataWithProductsArray:(NSArray *) productsArray;
- (void) clearAndResetDatabase;

@end
