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

    } else {
        NSLog(@"user needs to log in");
        // show the signup or login screen
    }
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
   // FBLoginView *loginView =
   // [[FBLoginView alloc] initWithReadPermissions:
    // @[@"public_profile", @"email", @"user_friends", @"read_stream"]];
    
   // loginView.center = CGPointMake(200, 600);
    
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
- (IBAction)facebookLoginButton:(id)sender {
    NSLog(@"trying to log in to fb");
    UIButton* fbButton = (UIButton*)sender;
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

            } else {
                NSLog(@"User with facebook logged in!");
                [fbButton setImage:buttonImage forState:UIControlStateNormal];

            }
            [self _presentUserDetailsViewControllerAnimated:YES];
        }
    }];
    
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
