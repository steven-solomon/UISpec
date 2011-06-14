//
//  PathTests.m
//  UISpec
//
//  Created by Steve Solomon on 6/10/11.
//

#import "PathTests.h"
#import "Path.h"
#import "OCMock/OCMock.h"

@implementation PathTests

- (void)setUp
{
  
}

- (void)tearDown
{
   
}

- (void)testIllegalSetup
{
    GHAssertThrows([[Path alloc] init], @"Should throw exception");
}

- (void)testPath
{
    CGPoint start = CGPointMake(0, 13);
    CGPoint end = CGPointMake(20, 13);
    Path *path = [[Path alloc] initWithStartPoint:start endPoint:end];
    GHAssertNotNil(path, @"Path shouldn't be nil");
    
    // Test points have been set
    GHAssertTrue(CGPointEqualToPoint(start, [path startPoint]), @"The start point should have been assigned");
    GHAssertTrue(CGPointEqualToPoint(end, [path endPoint]), @"The end point should have been assigned");
    
    // Test slope is calculated correctly
    GHAssertEquals((int)0, [path slope], @"The path's slope should be 0");
    // Test distance between the two points is calculated correctly
    GHAssertEquals((int)20, [path distance], @"The distance between the two points should be 20");
    
    // Test midpoint is correct
    GHAssertTrue(CGPointEqualToPoint(CGPointMake(10,13), [path midPoint]), @"The midpoint should be (10, 13)");
    
    // likewise for y intercept
    GHAssertEquals((int)13, [path yIntercept], @"The y intercept should be 13");
    
    // Make sure step size for path is 1
    GHAssertEquals(3, [path stepSize], @"The step size should be 3");
}

/*
- (void)testIteratingOverPath
{
    CGPoint start = CGPointMake(0, 13);
    CGPoint end = CGPointMake(20, 13);
    Path *path = [[Path alloc] initWithStartPoint:start endPoint:end];
    
}*/

@end
