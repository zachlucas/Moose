//
//  ViewController.m
//  Moose
//
//  Created by Zach Lucas on 10/21/14.
//  Copyright (c) 2014 Zach Lucas. All rights reserved.
//

#import "ViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Twitter/Twitter.h>
#import <Parse/Parse.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    FBLoginView *loginView = [[FBLoginView alloc] init];
    //loginView.center = self.view.center;
    //[self.view addSubview:loginView];
    // Twitter
    /*TWTRLogInButton* logInButton =  [TWTRLogInButton
                                     buttonWithLogInCompletion:
                                     ^(TWTRSession* session, NSError* error) {
                                         if (session) {
                                             NSLog(@"signed in as %@", [session userName]);
                                         } else {
                                             NSLog(@"error: %@", [error localizedDescription]);
                                         }
                                     }];
    logInButton.center = self.view.center;
    [self.view addSubview:logInButton];*/
    
    //PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    //testObject[@"foo"] = @"bar";
    //[testObject saveInBackground];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
