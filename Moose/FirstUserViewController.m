//
//  EntranceViewController.m
//  Moose
//
//  Created by Zach Lucas on 1/27/15.
//  Copyright (c) 2015 Zach Lucas. All rights reserved.
//

#import "FirstUserViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>

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
- (IBAction)startButton:(id)sender {
    PFUser* curUser = [PFUser currentUser];
    
    
    curUser[@"gender"] = [self.genderPicker titleForSegmentAtIndex:self.genderPicker.selectedSegmentIndex];
    curUser[@"lookingFor"] = [self.lookingForPicker titleForSegmentAtIndex:self.lookingForPicker.selectedSegmentIndex];
    
    [curUser saveInBackground];
    
    PFQuery *query = [PFUser query];
    [query whereKey:@"gender" equalTo:@"Girl"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu users.", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                [self getStatusesForUser:object];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    [self dismissViewControllerAnimated:YES completion:^{}];
    
    
}

-(void) getStatusesForUser: (PFObject*) user
{
    PFQuery* q = [PFQuery queryWithClassName:@"status"];
    [q whereKey:@"username" equalTo:user[@"username"]];
    [q findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu statuses.", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object[@"text"]);
                
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:@"returned_statuses"
                 object:object];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}


@end
