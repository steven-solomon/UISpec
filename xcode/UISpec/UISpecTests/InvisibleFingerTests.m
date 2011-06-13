//
//  InvisibleFingerTests.m
//  UISpec
//
//  Created by Steve Solomon on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InvisibleFingerTests.h"
#import "OCMock/OCMock.h"
#import "InvisibleFinger.h"
#import "TouchSynthesis.h"

@implementation InvisibleFingerTests

- (void)setUp
{
    point = CGPointMake(10, 0);
    view = [[UIView alloc] init];
    finger = [[InvisibleFinger alloc] initWithPoint:point andTarget:view];
    gestureRecognized = NO;
}

- (void)tearDown
{
    [finger release];
    [view release];
}

- (void)testFingerSetup
{
    // Tap setup
    GHAssertNotNil(finger, @"Finger shouldn't be nil");
    GHAssertTrue(CGPointEqualToPoint(point, [finger point]), @"Finger should contain the point");
    GHAssertEqualObjects(view, [finger targetView], @"Finger's target should have been set");
    
}

- (void)testIllegalInstance
{
    GHAssertThrows([[InvisibleFinger alloc] init], @"Init method shouldn't be allowed");
}

// Observe that structs assignment creates copies with identical values
- (void)testLearningThatFingerIsImmutable
{   
    // attempt to change point
    CGPoint innerPoint = [finger point];
    innerPoint.x = 52;
    
    GHAssertTrue(CGPointEqualToPoint(point, [finger point]), @"Finger should be immutable");
    
    // attempt to change our point 
    point.x = 52;
    GHAssertFalse(CGPointEqualToPoint(point, [finger point]), @"Finger should be immutable");
}

- (void)testPerformTouch
{    
    // Since alot of the gesture structure is undocumented we have to use a partial mock
    UIGestureRecognizer *recognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self 
                                                                               action:@selector(recognized:)] autorelease];
    [view addGestureRecognizer:recognizer];
    
    [finger performGestures];
    
    // sleep long enough to wait for recognizer to call recognized: method
    [NSThread sleepForTimeInterval:0.25];
    
    GHAssertTrue(gestureRecognized, @"The gesture should have been recognized");
}

/*
- (void)testPerformSwipe
{
    // Pan setup
    CGPoint endPoint = CGPointMake(10, 50);
    InvisibleFinger *panfinger = [[InvisibleFinger alloc] initWithStartPoint:point 
                                                                    endPoint:endPoint 
                                                                   andTarget:view];
    GHAssertNotNil(panfinger, @"Finger shouldn't be nil");
    
    UIGestureRecognizer *recognizer = [[[UITapGestureRecognizer alloc] init] autorelease];
    id mockGestureRecognizer = [OCMockObject partialMockForObject:recognizer];
    [[mockGestureRecognizer expect] touchesBegan:[OCMArg any] withEvent:[OCMArg any]];
    [[mockGestureRecognizer expect] touchesMoved:[OCMArg any] withEvent:[OCMArg any]];
    [[mockGestureRecognizer expect] touchesEnded:[OCMArg any] withEvent:[OCMArg any]];
    
    [view addGestureRecognizer:mockGestureRecognizer];
    
    [panfinger performGestures];
    
    GHAssertTrue(gestureRecognized, @"The pan event should have resulted in the gesture being recognized");
    
    [mockGestureRecognizer verify];
}*/

- (void)recognized:(UIGestureRecognizer *)recognizer
{
    gestureRecognized = YES;
}
@end
