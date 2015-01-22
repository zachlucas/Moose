//
//  UICardView.m
//  Moose
//
//  Created by Zach Lucas on 12/22/14.
//  Copyright (c) 2014 Zach Lucas. All rights reserved.
//

#import "UICardView.h"
#import <QuartzCore/QuartzCore.h>

CFTimeInterval startTime;
CGPoint startPoint;
CGPoint oldPoint;
BOOL imageViewTouched;


@implementation UICardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{
    NSLog(@"Card loaded");
    self.layer.zPosition = 10;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"first_status"
                                               object:nil];

}

- (void)viewDidLoad {
    // Tinder but most recent
    // status or tweet
    // rather than photo
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    // Test to see if the touched view is your image view. If not just return.
    if (touch.view != self) {
        return;
    }
    
    originalPosition = self.frame;
    
    startPoint = [touch locationInView:self];
    oldPoint = startPoint;
    startTime = CACurrentMediaTime();
    imageViewTouched = YES;
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *aTouch = [touches anyObject];
    CGPoint location = [aTouch locationInView:self];
    CGPoint previousLocation = [aTouch previousLocationInView:self];
    self.frame = CGRectOffset(self.frame, (location.x - previousLocation.x), (location.y - previousLocation.y));
        
    if (self.frame.origin.x > 175){
        [self setBackgroundColor:[UIColor greenColor]];
    }
    else if (self.frame.origin.x < -175){
        [self setBackgroundColor:[UIColor redColor]];
    }
    else{
        [self setBackgroundColor:[UIColor whiteColor]];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches ended");
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.35f initialSpringVelocity:0.25f options:nil animations:^{
        [self setFrame:originalPosition];
    }completion:nil];

}

- (void) receiveTestNotification:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    
    if ([[notification name] isEqualToString:@"first_status"]){
        NSLog (@"Successfully received the test notification!");
        NSLog(@":::%@",notification.userInfo);
    }
}



@end
