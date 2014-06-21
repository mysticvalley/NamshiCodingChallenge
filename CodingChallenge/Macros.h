//
//  Macros.h
//  CodingChallenge
//
//  Created by TekTak on 6/21/14.
//  Copyright (c) 2014 Namshi. All rights reserved.
//

#pragma mark - BASICS

#define     SQLITE_FILE                         @"namshi.sqlite"
#define     UI_ALERT_OK(TITLE,MSG)              [[[UIAlertView alloc] initWithTitle:(TITLE) \
                                                message:(MSG) \
                                                delegate:nil \
                                                cancelButtonTitle:@"OK" \
                                                otherButtonTitles:nil] show]


#pragma mark - NAMSHI REST URLS

#define     BASE_NAMSHI_API_ADDRESS             @"http://api.namshi.com"
#define     PRODUCT_API_URL                     BASE_NAMSHI_API_ADDRESS @"/products/"

