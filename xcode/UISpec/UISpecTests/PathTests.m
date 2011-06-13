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

- (void)testSetup
{
    Path *path = [[Path alloc] initWithStartPoint:CGPointZero endPoint:CGPointZero];
    GHAssertNotNil(path, @"Path shouldn't be nil");

}
@end
