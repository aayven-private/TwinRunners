//
//  CommonTools.m
//  twinrunners
//
//  Created by Ivan Borsa on 20/05/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import "CommonTools.h"

#define ARC4RANDOM_MAX 0x100000000

@implementation CommonTools

+(int)getRandomNumberFromInt:(int)from toInt:(int)to
{
    return from + arc4random() %(to+1-from);;
}

+(float)getRandomFloatFromFloat:(float)from toFloat:(float)to
{
    return ((float)arc4random() / ARC4RANDOM_MAX) * (to-from) + from;
}

@end

