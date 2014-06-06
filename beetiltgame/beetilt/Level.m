//
//  Level.m
//  twinrunners
//
//  Created by Ivan Borsa on 06/06/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import "Level.h"

@implementation Level

-(id)initWithRows:(NSArray *)rows andTiming:(float)timing
{
    if (self = [super init]) {
        self.rows = rows;
        self.timing = timing;
    }
    return self;
}

@end
