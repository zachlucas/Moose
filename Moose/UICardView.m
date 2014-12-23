//
//  UICardView.m
//  Moose
//
//  Created by Zach Lucas on 12/22/14.
//  Copyright (c) 2014 Zach Lucas. All rights reserved.
//

#import "UICardView.h"

@implementation UICardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)viewDidLoad {
    
    NSLog(@"Card loaded");
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *aTouch = [touches anyObject];
    CGPoint location = [aTouch locationInView:self];
    CGPoint previousLocation = [aTouch previousLocationInView:self];
    self.frame = CGRectOffset(self.frame, (location.x - previousLocation.x), (location.y - previousLocation.y));
}


@end
