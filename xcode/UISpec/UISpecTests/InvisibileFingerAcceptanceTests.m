//
//  InvisibileFingerAcceptanceTests.m
//  UISpec
//
//  Created by Steve Solomon on 6/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InvisibileFingerAcceptanceTests.h"
#import "InvisibleFinger.h"

@implementation InvisibileFingerAcceptanceTests

- (void)setUp
{
    [super setUp];
    
    point = CGPointMake(10, 0);
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 500, 500)];
    finger = [[InvisibleFinger alloc] initWithPoint:point andTarget:view];
    gestureRecognized = NO;
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testPerformTap
{    
    // Since alot of the gesture structure is undocumented we have to use a partial mock
    UIGestureRecognizer *recognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self 
                                                                               action:@selector(recognized:)] autorelease];
    [view addGestureRecognizer:recognizer];
    
    [finger performGestures];
    
    [self waitForRecogition];
    
    GHAssertTrue(gestureRecognized, @"The gesture should have been recognized");
}


- (void)testPerformSwipe
{
    
    // Pan setup
    CGPoint startPoint = CGPointMake(200, 50);
    CGPoint endPoint = CGPointMake(10, 50);
    InvisibleFinger *swipefinger = [[InvisibleFinger alloc] initWithStartPoint:startPoint 
                                                                      endPoint:endPoint 
                                                                     andTarget:view];
    GHAssertNotNil(swipefinger, @"Finger shouldn't be nil");
    
    UIGestureRecognizer *recognizer = [[[UISwipeGestureRecognizer alloc] init] autorelease];
    
    [view addGestureRecognizer:recognizer];
    
    [swipefinger performGestures];
    
    [self waitForRecogition];
    
    GHAssertTrue(gestureRecognized, @"The pan event should have resulted in the gesture being recognized");
    
}

- (void)recognized:(UIGestureRecognizer *)recognizer
{
    gestureRecognized = YES;
}

// Help deal with the fact that gesture recognition is asyncronous
- (void)waitForRecogition
{
    // sleep long enough to wait for recognizer to call recognized: method
    int timeout = 4;
    
    // sleep four times to check if gesture method has been called
    for (int count = 0; count < timeout; count++)
    {
        [NSThread sleepForTimeInterval:1.0];
        
        if (gestureRecognized == YES)
        {
            break;
        }
    }
    
}

@end
