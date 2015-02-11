//
//  EntranceViewController.h
//  Moose
//
//  Created by Zach Lucas on 1/27/15.
//  Copyright (c) 2015 Zach Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstUserViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *genderPicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *lookingForPicker;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@end
