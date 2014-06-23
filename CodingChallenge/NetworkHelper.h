//
//  NetworkHelper.h
//  CodingChallenge
//
//  Created by Rajan Maharjan on 6/19/14.
//  Copyright (c) 2014 Namshi. All rights reserved.
//

/*
 *  This class contains code to communicate with remote server via Internet
 */

#import <Foundation/Foundation.h>
#import <MKNetworkKit/MKNetworkKit.h>

typedef void (^CompletionBlock)(MKNetworkOperation *completedOperation);
typedef void (^ErrorBlock)(MKNetworkOperation *completedOperation, NSError *error);

@interface NetworkHelper : NSObject

+ (instancetype) sharedHelper;

- (void) GETRequestWithURL:(NSString *) url completionBlock:(CompletionBlock) runBlock errorBlock:(ErrorBlock) runErrorBlock;

- (void) POSTRequestWithURL:(NSString *) url params:(NSDictionary *) params completionBlock:(CompletionBlock) runBlock errorBlock:(ErrorBlock) runErrorBlock;

@end
