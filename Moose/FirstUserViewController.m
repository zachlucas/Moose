//
//  EntranceViewController.m
//  Moose
//
//  Created by Zach Lucas on 1/27/15.
//  Copyright (c) 2015 Zach Lucas. All rights reserved.
//

#import "FirstUserViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface FirstUserViewController ()

@end

@implementation FirstUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)genderPicker:(id)sender {
    [self.genderPicker setTag:2];
    
    if (self.lookingForPicker.tag) {
        [self.startButton setHidden:false];
    }
}
- (IBAction)lookingForPicker:(id)sender {
    [self.lookingForPicker setTag:2];
    
    if (self.genderPicker.tag){
        [self.startButton setHidden:false];
    }
}

@end
