//
//  EntranceViewController.m
//  Moose
//
//  Created by Zach Lucas on 1/27/15.
//  Copyright (c) 2015 Zach Lucas. All rights reserved.
//

#import "EntranceViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface EntranceViewController ()

@end

@implementation EntranceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _welcomeLabel.center = CGPointMake(150, -250);
    _welcomeLabel.alpha = 0;
    _welcomeLabel.transform = CGAffineTransformMakeScale(0.4, 0.4);
    [UIView animateWithDuration:3.0f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         _welcomeLabel.center = CGPointMake(150,500);
         _welcomeLabel.alpha = 1;
         _welcomeLabel.transform = CGAffineTransformMakeScale(1,1);
     }
                     completion:^(BOOL finished) {
                         [self performSegueWithIdentifier:@"enterMoose" sender:nil];
                     }];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
