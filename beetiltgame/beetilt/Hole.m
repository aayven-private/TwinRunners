//
//  Hole.m
//  twinrunners
//
//  Created by Ivan Borsa on 16/05/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import "Hole.h"

@implementation Hole

-(id)initWithColor:(UIColor *)color size:(CGSize)size
{
    if (self = [super initWithColor:color size:size]) {
        self.type = kObjectTypeHole;
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:size.width / 3.0f];
        self.physicsBody.categoryBitMask = kObjectCategoryHole;
        self.physicsBody.collisionBitMask = 0;
        self.physicsBody.contactTestBitMask = kObjectCategoryRunner;
        self.physicsBody.usesPreciseCollisionDetection = YES;
        self.physicsBody.dynamic = NO;
        self.physicsBody.affectedByGravity = NO;
    }
    return self;
}

@end
