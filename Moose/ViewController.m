//
//  ViewController.m
//  Moose
//
//  Created by Zach Lucas on 10/21/14.
//  Copyright (c) 2014 Zach Lucas. All rights reserved.
//

#import "ViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    FBLoginView *loginView = [[FBLoginView alloc] init];
    //loginView.center = self.view.center;
    //[self.view addSubview:loginView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
