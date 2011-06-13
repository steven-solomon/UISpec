//
//  InvisibleFingerTests.h
//  UISpec
//
//  Created by Steve Solomon on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>

@class InvisibleFinger;
@interface InvisibleFingerTests : GHTestCase
{
    UIView *view;
    CGPoint point;
    InvisibleFinger *finger;
    BOOL gestureRecognized;
}
- (void)recognized:(UIGestureRecognizer *)recognizer;
// Helper method to wait for background thread to call recognized:
- (void)waitForRecogition;
@end
