//
//  GameScene.m
//  beetilt
//
//  Created by Ivan Borsa on 22/04/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import "GameScene.h"

@interface GameScene()

@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;

@end

@implementation GameScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
    }
    return self;
}

- (void)update:(NSTimeInterval)currentTime
{
    
    CFTimeInterval timeSinceLast = currentTime - _lastUpdateTimeInterval;
    if (timeSinceLast > 1) { // more than a second since last update
        timeSinceLast = 1.0 / 60.0;
    }
    _lastUpdateTimeInterval = currentTime;
    [self updateWithTimeSinceLastUpdate:timeSinceLast];
}

- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast
{
    
}

@end
