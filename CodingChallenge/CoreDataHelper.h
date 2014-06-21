//
//  CoreDataHelper.h
//  CodingChallenge
//
//  Created by TekTak on 6/21/14.
//  Copyright (c) 2014 Namshi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataHelper : NSObject

+ (instancetype) sharedHelper;

#pragma mark - REST Operations

- (void) saveProductsToCoreDataWithProductsArray:(NSArray *) productsArray;

@end
