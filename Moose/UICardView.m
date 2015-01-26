//
//  UICardView.m
//  Moose
//
//  Created by Zach Lucas on 12/22/14.
//  Copyright (c) 2014 Zach Lucas. All rights reserved.
//

#import "UICardView.h"
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>

#define NUMBER_OF_STATUSES_TO_SAVE 5

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

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    
    
    return self;
}

- (void)awakeFromNib{
    NSLog(@"Card loaded");
    self.layer.zPosition = 10;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"first_status"
                                               object:nil];

}

- (void)viewDidLoad {
    [[self subviews] objectAtIndex:0];
    
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
        NSLog(@":::%@",[notification.object firstObject]);
        NSLog(@"UILabel: %@",self.statusLabel);
        NSString* statusText = [[notification.object firstObject] objectForKey:@"message"];
        [self.statusLabel setText:statusText];
        
        NSString* dateWithInitialFormat = [[notification.object firstObject] objectForKey:@"updated_time"];
        dateWithInitialFormat = [dateWithInitialFormat substringToIndex:10];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [dateFormatter dateFromString:dateWithInitialFormat];
        
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
        NSString *dateWithNewFormat = [dateFormatter stringFromDate:date];
        NSLog(@"dateWithNewFormat: %@", dateWithNewFormat);
        
        [self.dateLabel setText:dateWithNewFormat];
        
        PFUser* currentUser = [PFUser currentUser];
        
        for (int i = 0; i<NUMBER_OF_STATUSES_TO_SAVE; i++) {
            if ([notification.object objectAtIndex:i]){
                NSString* statusTextToSave = [[notification.object objectAtIndex:i] objectForKey:@"message"];
                
                NSString* dateWithInitialFormatToSave = [[notification.object objectAtIndex:i] objectForKey:@"updated_time"];
                dateWithInitialFormatToSave = [dateWithInitialFormatToSave substringToIndex:10];
                NSDateFormatter *dateFormatterToSave = [[NSDateFormatter alloc] init];
                [dateFormatterToSave setDateFormat:@"yyyy-MM-dd"];
                NSDate *dateToSave = [dateFormatterToSave dateFromString:dateWithInitialFormatToSave];

                PFObject *status = [PFObject objectWithClassName:@"status"];
                status[@"username"] = currentUser.username;
                status[@"text"] = statusTextToSave;
                status[@"date"] = dateToSave;
                [status saveInBackground];
            }
        }
        
    }
}



@end
