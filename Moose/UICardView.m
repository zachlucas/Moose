//
//  UICardView.m
//  Moose
//
//  Created by Zach Lucas on 12/22/14.
//  Copyright (c) 2014 Zach Lucas. All rights reserved.
//

#import "UICardView.h"

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

- (void)viewDidLoad {
    // Tinder but most recent
    // status or tweet
    // rather than photo
    
    NSLog(@"Card loaded");
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    // Test to see if the touched view is your image view. If not just return.
    if (touch.view != self) {
        return;
    }
    
    startPoint = [touch locationInView:self];
    oldPoint = startPoint;
    startTime = CACurrentMediaTime();
    imageViewTouched = YES;
}
/*
-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *aTouch = [touches anyObject];
    CGPoint location = [aTouch locationInView:self];
    CGPoint previousLocation = [aTouch previousLocationInView:self];
    self.frame = CGRectOffset(self.frame, (location.x - previousLocation.x), (location.y - previousLocation.y));
        
    if (self.frame.origin.x > 200){
        [self setBackgroundColor:[UIColor greenColor]];
    }
    else if (self.frame.origin.x < -200){
        [self setBackgroundColor:[UIColor redColor]];
    }
    else{
        [self setBackgroundColor:[UIColor whiteColor]];
    }
}*/

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{

    // Fingers were moved on the screen but your image view was not touched in the beginning
    if (!imageViewTouched) {
        return;
    }
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint newPoint = [touch locationInView:self];
    
    self.frame = CGRectOffset(self.frame, newPoint.x - oldPoint.x, newPoint.y - oldPoint.y);
    
    NSLog(@"new loc: %f, %f",newPoint.x - oldPoint.x,newPoint.y - oldPoint.y);
    NSLog(@"oldpoint: %f,%f",oldPoint.x,oldPoint.y);
    NSLog(@"newpoint: %f,%f",newPoint.x,newPoint.y);

    oldPoint = newPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Fingers were removed from the screen but your image view was not touched in the beginning
    if (!imageViewTouched) {
        return;
    }
    
    imageViewTouched = NO;
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint endPoint = [touch locationInView:self];
    CFTimeInterval endTime = CACurrentMediaTime();
    
    CFTimeInterval timeDifference = endTime - startTime;
    
    // You may play with this value until you get your desired effect
    CGFloat maxSpeed = 200;
    
    CGFloat deltaX = 0;
    CGFloat deltaY = 0;
    
    if (timeDifference < 0.35) {
        deltaX = (endPoint.x - startPoint.x) / (timeDifference * 10);
        deltaY = (endPoint.y - startPoint.y) / (timeDifference * 10);
    }
    
    if      (deltaX > maxSpeed)         { deltaX =  maxSpeed; }
    else if (deltaX < -maxSpeed)        { deltaX = -maxSpeed; }
    else if (deltaX > -5 && deltaX < 5) { deltaX = 0; }
    
    if      (deltaY > maxSpeed)         { deltaY =  maxSpeed; }
    else if (deltaY < -maxSpeed)        { deltaY = -maxSpeed; }
    else if (deltaY > -5 && deltaY < 5) { deltaY = 0; }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    self.frame = CGRectOffset(self.frame, deltaX, deltaY);
    
    [UIView commitAnimations];
}


@end
