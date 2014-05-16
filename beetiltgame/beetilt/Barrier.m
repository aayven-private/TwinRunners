//
//  Barrier.m
//  twinrunners
//
//  Created by Ivan Borsa on 16/05/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import "Barrier.h"

@implementation Barrier

-(id)initWithTexture:(SKTexture *)texture
{
    if (self = [super initWithTexture:texture]) {
        self.type = kObjectTypeBarrier;
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:texture.size];
        self.physicsBody.categoryBitMask = kObjectCategoryBarrier;
        self.physicsBody.collisionBitMask = 0;
        self.physicsBody.contactTestBitMask = kObjectCategoryRunner;
        self.physicsBody.usesPreciseCollisionDetection = YES;
        self.physicsBody.dynamic = NO;
        self.physicsBody.affectedByGravity = NO;
    }
    return self;
}

@end
