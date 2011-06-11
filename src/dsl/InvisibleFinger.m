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

- (id)initWithPoint:(CGPoint)aPoint andTarget:(UIView *)view
{
    if (self = [super init]) 
    {
        point = aPoint;
        [self setTargetView:view];
    }
    
    return self;
}

// Helper method to abstract sending event messages to all recognizers for our target view
- (void)sendSelector:(SEL)selector withEvent:(UIEvent *)event andTouches:(NSSet *)touches
{
    // Send event to the gesture recognizers
    for (UIGestureRecognizer *recognizer in [targetView gestureRecognizers])
    {
        // Sure this is ugly but compiler warnings are uglier
        [recognizer performSelector:selector 
                         withObject:touches 
                         withObject:event];
    }

}
- (void)performTouch
{
    NSSet *touches = [[[NSSet alloc] init] autorelease];
    UIEvent *event = [[[UIEvent alloc] init] autorelease];
    
    // Send begining event
    [self sendSelector:@selector(touchesBegan:withEvent:) withEvent:event andTouches:touches];
    
    // Send ending event
    [self sendSelector:@selector(touchesEnded:withEvent:) withEvent:event andTouches:touches];
}


@end
