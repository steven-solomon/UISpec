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
    
    GHAssertTrue(CGPointEqualToPoint(start, [path startPoint]), @"The start point should have been assigned");
    GHAssertTrue(CGPointEqualToPoint(end, [path endPoint]), @"The end point should have been assigned");
    
    GHAssertEquals((float)0.0, [path slope], @"The path's slope should be 0");
}
@end
