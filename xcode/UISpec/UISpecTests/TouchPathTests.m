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

- (void)testTouchPathCreation 
{
    CGPoint point = CGPointMake(0, 0);
    TouchPath *path = [[TouchPath alloc] initWithPoint:point];
    
    GHAssertNotNil(path, @"Path shouldn't be nil");
    
    //GHAssertTrue(CGPointEqualToPoint(point, [path point]), @"Touch should contain the point");
}

@end
