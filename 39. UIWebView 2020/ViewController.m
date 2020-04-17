//
//  ViewController.m
//  39. UIWebView 2020
//
//  Created by Dmitry Marchenko on 4/17/20.
//  Copyright © 2020 Dmitry Marchenko. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "PathItem.h"

@interface ViewController () <WKNavigationDelegate>

@property (weak, nonatomic)  UIActivityIndicatorView *webActivityIndicator;
@property (strong, nonatomic) WKWebView *webView;

@end


@implementation ViewController

#pragma mark - Setters

- (void)setPathItem:(PathItem *)pathItem {
    
    _pathItem = pathItem;
    
    WKWebViewConfiguration *webConfiguration = [[WKWebViewConfiguration alloc] init];
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:webConfiguration];
    self.webView.navigationDelegate = self;
    
    UIActivityIndicatorView *webActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    webActivityIndicator.color = [UIColor colorWithRed:0.0 green:122.0/255.f blue:1.0 alpha:1.0];
    webActivityIndicator.hidesWhenStopped = YES;
    webActivityIndicator.center = self.view.center;
    self.webActivityIndicator = webActivityIndicator;
    
    [self.webView addSubview:webActivityIndicator];
    
    self.view = self.webView;
    
    NSURL *URL;
    
    if (_pathItem.type == PathItemTypeWebPage) {
        
        URL = [NSURL URLWithString:_pathItem.path];

    } else if (_pathItem.type == PathItemTypePDF) {
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:_pathItem.path ofType:nil];
        URL = [NSURL fileURLWithPath:filePath];
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [self.webView loadRequest:request];
}


#pragma mark - Actions

- (IBAction)backBarButtonItemPressed:(UIBarButtonItem *)sender {
    
    [self.webView canGoBack] ? [self.webView goBack] : 0;
}

- (IBAction)forwardBarButtonItemPressed:(UIBarButtonItem *)sender {
    
    [self.webView canGoForward] ? [self.webView goForward] : 0;
}


#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
    [self changeActivityIndicatorsState];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    
    [self changeActivityIndicatorsState];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
    [self changeActivityIndicatorsState];
}

- (void)changeActivityIndicatorsState {
    
    UIApplication *application = [UIApplication sharedApplication];
    application.networkActivityIndicatorVisible = !application.networkActivityIndicatorVisible;
    
    [self.webActivityIndicator isAnimating] ? [self.webActivityIndicator stopAnimating] : [self.webActivityIndicator startAnimating];
}

@end
