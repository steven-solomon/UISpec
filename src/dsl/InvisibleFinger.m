//
//  InvisibleFinger.m
//  UISpec
//
//  Created by Steve Solomon on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InvisibleFinger.h"
#import "VisibleTouch.h"
#import "TouchSynthesis.h"
#import "EventSynthesis.h"
#import "Path.h"

@implementation InvisibleFinger

@synthesize point;
@synthesize targetView;
@synthesize path;

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

- (id)initWithStartPoint:(CGPoint)start endPoint:(CGPoint)end andTarget:(UIView *)view
{
    if (self = [super init]) 
    {
        path = [[Path alloc] initWithStartPoint:start endPoint:end];
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
- (void)performEvent:(UIEvent *)event withTouch:(UITouch *)touch
{
    NSSet *touches = [[NSSet alloc] initWithObjects:&touch count:1];
    
    // Display a visible touch on screen
    CGPoint convertedPoint = [[targetView superview] convertPoint:point fromView:targetView];
    VisibleTouch *visibleTouch = [[VisibleTouch alloc] initWithCenter:convertedPoint];
    [[targetView superview] addSubview:visibleTouch];
    [[targetView superview] bringSubviewToFront:visibleTouch];
     
    // Display 
    // Send begining event
    [self sendSelector:@selector(touchesBegan:withEvent:) withEvent:event andTouches:touches];
    [targetView touchesBegan:touches withEvent:event];

    // Change touch phase
    [touch setPhase:UITouchPhaseEnded];
    
    // Pause to allow for touch to be seen
    CFRunLoopRunInMode(kCFRunLoopDefaultMode, .25, false);
    
    // Send ending event
    [self sendSelector:@selector(touchesEnded:withEvent:) withEvent:event andTouches:touches];
    [targetView touchesEnded:touches withEvent:event];
    
    [visibleTouch removeFromSuperview];
    [visibleTouch release];
    [touches release];
}

- (void)performSwipeEvent:(UIEvent *)event withTouch:(UITouch *)touch
{
    
    NSSet *touches = [NSSet setWithObjects:&touch count:1];
    
    // Begin Event
    [self sendSelector:@selector(touchesBegan:withEvent:) withEvent:event andTouches:touches];
    [targetView touchesBegan:touches withEvent:event];
    
    // Get point
    NSArray *points = [path points];
    
    // Move from second point to last point in path generating move events along the way
    for (int i = 1; i < [points count]; i++)
    {        
        
        CGPoint aPoint = [points CGPointAtIndex:i];
        [touch setLocationInWindow:aPoint];
        [touch setPhase:UITouchPhaseMoved];
        [self sendSelector:@selector(touchesMoved:withEvent:) withEvent:event andTouches:touches];
        [targetView touchesMoved:touches withEvent:event];
    }
    
    // End Event
    [touch setPhase:UITouchPhaseEnded];
    [self sendSelector:@selector(touchesEnded:withEvent:) withEvent:event andTouches:touches];
    [targetView touchesEnded:touches withEvent:event];
    
}

- (void)performTapGesture
{
    // Create touch and event
    UITouch *touch = [[UITouch alloc] initInView:targetView 
                                          xcoord:(int)point.x 
                                          ycoord:(int)point.y];
    
    UIEvent *event = [[NSClassFromString(@"UITouchesEvent") alloc] initWithTouch:touch];
    
    [self performEvent:event withTouch:touch];
    
    [touch release];
    [event release];
}

- (void)performGestures
{
    if (path != nil)
    {
        // Get point
        CGPoint aPoint = [path startPoint];
        
        // Create touch event
        UITouch *touch = [[UITouch alloc] initInView:targetView 
                                              xcoord:(int)aPoint.x 
                                              ycoord:(int)aPoint.y];
        UIEvent *event = [[NSClassFromString(@"UITouchesEvent") alloc] initWithTouch:touch];
        
        // Perform swipe
        [self performSwipeEvent:event withTouch:touch];
                
        [touch release];
        [event release];
    }
    else
    {
        // if we don't have a path then we are dealling with a single touch
        [self performTapGesture];
    }
}

@end

@implementation NSArray (CGPointHelper)

- (CGPoint)CGPointAtIndex:(NSUInteger)index
{
    NSValue *value = [self objectAtIndex:index]; 
    CGPoint aPoint = [value CGPointValue];
    return aPoint;
}
@end
