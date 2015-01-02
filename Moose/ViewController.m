//
//  ViewController.m
//  Moose
//
//  Created by Zach Lucas on 10/21/14.
//  Copyright (c) 2014 Zach Lucas. All rights reserved.
//

#import "ViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <Twitter/Twitter.h>
#import <Parse/Parse.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        // do stuff with the user
        NSLog(@"user logged in already");
        UIImage * buttonImage = [UIImage imageNamed:@"fb_logout.png"];
        [_fbLoginButton setImage:buttonImage forState:UIControlStateNormal];
        [_fbLoginButton setTag:1];

    } else {
        NSLog(@"user needs to log in");
        [_fbLoginButton setTag:2];
        // show the signup or login screen
    }
    
    [self _loadData];
}

- (void)_loadData {
    // ...
    FBRequest *request = [FBRequest requestForGraphPath:@"/me/statuses"];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        // handle response
        NSLog(@"FB Reuqest made");
        NSLog(@"result: %@",result);
    }];
}

- (IBAction)facebookLoginButton:(id)sender {
    UIButton* fbButton = (UIButton*)sender;
    if (fbButton.tag == 1) {
        NSLog(@"Log out");
        
        [PFUser logOut];
        PFUser *currentUser = [PFUser currentUser]; // this will now be nil
        [[FBSession activeSession] closeAndClearTokenInformation];
        [fbButton setTag:2];
        [fbButton setImage:[UIImage imageNamed:@"fb_login.png"] forState:UIControlStateNormal];
    }
    else{
        NSLog(@"trying to log in to fb");
        UIImage * buttonImage = [UIImage imageNamed:@"fb_logout.png"];

        // Set permissions required from the facebook user account
        NSArray *permissionsArray = @[ @"user_about_me", @"read_stream", @"user_birthday", @"user_location"];
        
        // Login PFUser using Facebook
        [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
            //[_activityIndicator stopAnimating]; // Hide loading indicator
            
            if (!user) {
                NSString *errorMessage = nil;
                if (!error) {
                    NSLog(@"Uh oh. The user cancelled the Facebook login.");
                    errorMessage = @"Uh oh. The user cancelled the Facebook login.";
                } else {
                    NSLog(@"Uh oh. An error occurred: %@", error);
                    errorMessage = [error localizedDescription];
                }
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error"
                                                                message:errorMessage
                                                               delegate:nil
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"Dismiss", nil];
                [alert show];
            } else {
                if (user.isNew) {
                    NSLog(@"User with facebook signed up and logged in!");
                    [fbButton setImage:buttonImage forState:UIControlStateNormal];
                    [fbButton setTag:1];
                    
                    FBRequest *request = [FBRequest requestForGraphPath:@"/me/statuses"];
                    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                        // handle response
                        NSLog(@"FB Reuqest made");
                        NSLog(@"result: %@",result);
                    }];


                } else {
                    NSLog(@"User with facebook logged in!");
                    [fbButton setImage:buttonImage forState:UIControlStateNormal];
                    [fbButton setTag:1];
                    
                    FBRequest *request = [FBRequest requestForGraphPath:@"/me/statuses"];
                    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                        // handle response
                        NSLog(@"FB Request made");
                        NSLog(@"result: %@",result);
                    }];

                    
                }
                [self _presentUserDetailsViewControllerAnimated:YES];
            }
        }];
        
        if ([PFUser currentUser]) {
            NSLog(@"User with facebook ALREADY logged in");
            [fbButton setImage:buttonImage forState:UIControlStateNormal];
            [fbButton setTag:1];
        }

    }
    //[_activityIndicator startAnimating]; // Show loading indicator until login is finished
}

- (void)_presentUserDetailsViewControllerAnimated:(BOOL)animated {
    UITableViewController *detailsViewController = [[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:detailsViewController animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
