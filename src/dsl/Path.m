//
//  Path.m
//  UISpec
//
//  Created by Steve Solomon on 6/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Path.h"

@implementation Path

@synthesize startPoint;
@synthesize endPoint;

- (id)init
{
    @throw @"Illegal init method use: initWithPoint1:point2";
}

- (id)initWithStartPoint:(CGPoint)start endPoint:(CGPoint)end;
{
    if (self = [super init])
    {
        startPoint = start;
        endPoint = end;
    }
    
    return self;
}

@end
