//
//  UICardView.h
//  Moose
//
//  Created by Zach Lucas on 12/22/14.
//  Copyright (c) 2014 Zach Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICardView : UIView
{
    CGRect originalPosition;
    BOOL didUploadStatuses;
}

@property (weak,nonatomic) IBOutlet UILabel* statusLabel;
@property (weak,nonatomic) IBOutlet UILabel* dateLabel;

@end
