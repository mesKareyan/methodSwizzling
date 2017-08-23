//
//  ViewController.m
//  NSURLSessionSwizzlingExample
//
//  Created by Mesrop Kareyan on 8/23/17.
//  Copyright © 2017 none. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)sendRequest:(UIButton *)sender {
    
    NSURL *url = [NSURL URLWithString: @"https://www.listal.com/viewimage/3957198h"];
    NSURLRequest* request = [NSURLRequest requestWithURL: url];
        
    NSURLSessionTask *task = [[NSURLSession sharedSession]
                              dataTaskWithRequest: request
                                completionHandler:
     ^(NSData *data, NSURLResponse *response, NSError * error) {
     }];
                              
    [task resume];
    
}

@end
