//
//  WebViewController.m
//  CodingChallenge
//
//  Created by TekTak on 6/23/14.
//  Copyright (c) 2014 Namshi. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSURL *namshiURL = [NSURL URLWithString:@"https://en-ae.namshi.com/"];
    // Do any additional setup after loading the view.
    if ( self.urlToLoad )
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.urlToLoad]];
    else
        [self.webView loadRequest:[NSURLRequest requestWithURL:namshiURL]];
    
#warning -  Demo method to catch message from query parameter
//    [self catchAndShowQueryParamsViaSampleURL];
    
    [self.webView setScalesPageToFit:YES];
}

/*
 *  The following method assumes URL with custom message returned from server and gets the message from query string
 *  JUST FOR DEMO
 */

- (void) catchAndShowQueryParamsViaSampleURL {
    
    NSURL *namshi = [NSURL URLWithString:@"namshi://?message=HelloWorld"];
    NSLog(@"Namshi Message URL Host: %@, Query :%@, %@", namshi.host, namshi.query, namshi.scheme);
    
    if ( [namshi.scheme isEqualToString:@"namshi"] ) {
        
        // check if the query string contains message= substring
        NSString *searchString = @"message=";
        if ([namshi.query rangeOfString:searchString].location == NSNotFound) {
            NSLog(@"Qeury String does not contain searchString!");
        }
        else {
            NSLog(@"There is searchString in queryString!");
            
            // parsing the url and get the message, assume there is a '='for value, if you are passing multiple value, you might need to do more
            NSString* message = [[[[namshi query] componentsSeparatedByString: @"="] lastObject] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSString *catchedMessage = [NSString stringWithFormat:@"Catched Message: %@", message];
            UI_ALERT_OK(@"", catchedMessage);
            
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIWebView Delegate

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSURL* url = request.URL;
    
#warning - Actual catching of query paramters happens here
    // Check to see if we have message in query param from url
    // in "namshi://?message=<string>" format
    if ( [url.scheme isEqualToString:@"namshi"] ) {
        
        // check if the query string contains message= substring
        NSString *searchString = @"message=";
        if ([url.query rangeOfString:searchString].location == NSNotFound) {
            NSLog(@"Qeury String does not contain searchString!");
        }
        else {
            NSLog(@"There is searchString in queryString!");
         
            // parsing the url and get the message, assume there is a '='for value, if you are passing multiple value, you might need to do more
            NSString* message = [[[[url query] componentsSeparatedByString: @"="] lastObject] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSString *catchedMessage = [NSString stringWithFormat:@"Catched Message: %@", message];
            UI_ALERT_OK(@"", catchedMessage);
            return NO;
        }
    }
    return YES;
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    NSLog(@"URL load failed with error: %@", error.localizedDescription);
}

- (void) webViewDidFinishLoad:(UIWebView *)webView {
 
    NSLog(@"Finished Loading!");
}

- (void) webViewDidStartLoad:(UIWebView *)webView {
    
    NSLog(@"Started Loading URL");
}

@end
