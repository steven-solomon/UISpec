//
//  TouchPath.m
//  UISpec
//
//  Created by Steve Solomon on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TouchPath.h"

@implementation TouchPath

@synthesize point;

- (id)init
{
    @throw @"Illegal instantiation use initWithPoint instead";
}

- (id)initWithPoint:(CGPoint)initPoint
{
    
    if (self = [super init]) 
    {
        point = initPoint;
    }
    
    return self;
}

@end
