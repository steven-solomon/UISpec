//
//  Path.h
//  UISpec
//
//  Class to wrap solving of gesture path equation
//  for now we only support a simple linear path but who 
//  knows about the future =)
//
//  Created by Steve Solomon on 6/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Path : NSObject
{
    CGPoint startPoint;
    CGPoint endPoint;
}

// Desginated Initializer
- (id)initWithStartPoint:(CGPoint)start endPoint:(CGPoint)end;

@property (nonatomic, readonly) CGPoint startPoint;
@property (nonatomic, readonly) CGPoint endPoint;
@end
