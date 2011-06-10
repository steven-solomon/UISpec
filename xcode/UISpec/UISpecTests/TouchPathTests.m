//
//  ExampleTest.m
//  UISpec
//
//  Created by Steve Solomon on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TouchPathTests.h"
#import "TouchPath.h"

@implementation TouchPathTests

- (void)setUp
{
    point = CGPointMake(10, 0);
    path = [[TouchPath alloc] initWithPoint:point];
}

- (void)tearDown
{
    [path release];
}

- (void)testTouchPathCreation 
{
    GHAssertNotNil(path, @"Path shouldn't be nil");
    GHAssertTrue(CGPointEqualToPoint(point, [path point]), @"Touch should contain the point");
}

- (void)testIllegalCreation
{
    GHAssertThrows([[TouchPath alloc] init], @"Init method shouldn't be allow");
}

// Observe that structs assignment creates copies with identical values
- (void)testLearningThatPointIsImmutable
{   
    // attempt to change point
    CGPoint innerPoint = [path point];
    innerPoint.x = 52;
    
    GHAssertTrue(CGPointEqualToPoint(point, [path point]), @"Touch point should be immutable");
    
    // attempt to change our point 
    point.x = 52;
    GHAssertFalse(CGPointEqualToPoint(point, [path point]), @"Touch point should be immutable");
}



@end
