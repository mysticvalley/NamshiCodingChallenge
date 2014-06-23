//
//  WebViewController.h
//  CodingChallenge
//
//  Created by TekTak on 6/23/14.
//  Copyright (c) 2014 Namshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@end
