//
//  TouchPath.m
//  UISpec
//
//  Created by Steve Solomon on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InvisibleFinger.h"

@implementation InvisibleFinger

@synthesize point;
@synthesize targetView;

- (id)init
{
    @throw @"Illegal instantiation use initWithPoint instead";
}

- (id)initWithPoint:(CGPoint)initPoint
{
    
    if (self = [super init]) 
    {
        point = initPoint;
    }
    
    return self;
}

- (id)initWithPoint:(CGPoint)aPoint andTarget:(UIView *)view
{
    if (self = [super init]) 
    {
        point = aPoint;
        [self setTargetView:view];
    }
    
    return self;
}

- (void)performTouch
{
    // Send event to the gesture recognizers
    for (UIGestureRecognizer *recognizer in [targetView gestureRecognizers])
    {
        [recognizer touchesBegan:nil withEvent:nil];
    }
    
    for (UIGestureRecognizer *recognizer in [targetView gestureRecognizers])
    {
        [recognizer touchesEnded:nil withEvent:nil];
    }
}

@end
