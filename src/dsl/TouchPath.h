//
//  TouchPath.h
//  UISpec
//
//  Created by Steve Solomon on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TouchPath : NSObject
{
    CGPoint point; 
}

// Designated Initializer
-(id)initWithPoint:(CGPoint)point;

// Be aware point's default initialization is (0,0) 
@property (nonatomic, readonly) CGPoint point;
@end
