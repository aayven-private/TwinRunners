//
//  HudScene.m
//  twinrunners
//
//  Created by Ivan Borsa on 27/05/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import "HudScene.h"

@implementation HudScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    }
    return self;
}

@end
