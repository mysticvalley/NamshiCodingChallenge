
//  NetworkHelper.m
//  CodingChallenge
//
//  Created by Rajan Maharjan on 6/19/14.
//  Copyright (c) 2014 Namshi. All rights reserved.
//

#import "NetworkHelper.h"

@interface NetworkHelper ()

@end

@implementation NetworkHelper

+ (instancetype) sharedHelper
{
    static dispatch_once_t pred;
    static NetworkHelper *whatever = nil;
    dispatch_once(&pred, ^{
        whatever = [[NetworkHelper alloc] init];
    });
    return whatever;
}


- (void) GETRequestWithURL:(NSString *) url completionBlock:(CompletionBlock) runBlock errorBlock:(ErrorBlock) runErrorBlock {

    NSLog(@"Request URL is %@",url);
    MKNetworkOperation *getOperation = [[MKNetworkOperation alloc] initWithURLString:url
                                                                                         params:nil
                                                                                     httpMethod:@"GET"];
    [getOperation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        // On Completion Code
        runBlock(completedOperation);
    }
                                     errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
                                         // On Error Code
                                         runErrorBlock(completedOperation, error);
                                         
    }];
    
    [getOperation setCacheHandler:^(MKNetworkOperation *completedOperation) {
        /*
         *  Each time the operation is started, both CacheHandler & CompletionHandler are called, the CompletionHandler will return
         */
    }];
    
    [getOperation start];
}

- (void) POSTRequestWithURL:(NSString *) url params:(NSDictionary *) params completionBlock:(CompletionBlock) runBlock errorBlock:(ErrorBlock) runErrorBlock {
    
    NSLog(@"Requst url is %@",url);
    MKNetworkOperation *operation = [[MKNetworkOperation alloc] initWithURLString:url
                                                                                         params:params
                                                                                     httpMethod:@"POST"];
    [operation setPostDataEncoding:MKNKPostDataEncodingTypeJSON];

    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        // On Completion Code
        runBlock(completedOperation);
    }
    errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
                                         
        // On Error Code
    runErrorBlock(completedOperation, error);
    }];
    
    [operation setCacheHandler:^(MKNetworkOperation *completedOperation) {
        
        /*
         *  Each time the operation is started, both CacheHandler & CompletionHandler are called, the CompletionHandler will return
         */
    }];
    [operation setFreezable:YES];
    [operation start];
}

@end
