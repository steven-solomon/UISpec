//
//  TouchPath.h
//  UISpec
//
//  Created by Steve Solomon on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvisibleFinger : NSObject
{
    CGPoint point; 
    UIView *targetView;
}

// Designated Initializer
-(id)initWithPoint:(CGPoint)point;
- (id)initWithPoint:(CGPoint)aPoint andTarget:(UIView *)view;

// Be aware point's default initialization is (0,0) 
@property (nonatomic, readonly) CGPoint point;
@property (nonatomic, retain) UIView *targetView;
@end
