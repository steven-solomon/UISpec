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
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 500, 500)];
    finger = [[InvisibleFinger alloc] initWithPoint:point andTarget:view];
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

- (void)testTouchEvent
{    
    // Since alot of the gesture structure is undocumented we have to use a partial mock
    UIGestureRecognizer *recognizer = [[[UITapGestureRecognizer alloc] init] autorelease];
    id mockGestureRecognizer = [OCMockObject partialMockForObject:recognizer];
    [[mockGestureRecognizer expect] touchesBegan:[OCMArg any] withEvent:[OCMArg any]];
    [[mockGestureRecognizer expect] touchesEnded:[OCMArg any] withEvent:[OCMArg any]];
    
    [view addGestureRecognizer:mockGestureRecognizer];
    
    // Fake out touch so we can make sure it changes phase
    UITouch *touch = [[[UITouch alloc] init] autorelease];
    // create partial mock for touch
    id mockTouch = [OCMockObject partialMockForObject:touch];
    [[mockTouch expect] setPhase:UITouchPhaseEnded];
    
    // Exercise the finger 
    [finger performEvent:nil withTouch:mockTouch];
    
    [mockTouch verify];
    [mockGestureRecognizer verify];
}

@end
