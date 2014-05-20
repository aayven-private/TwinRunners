//
//  Runner.m
//  twinrunners
//
//  Created by Ivan Borsa on 16/05/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import "Runner.h"

@implementation Runner

-(id)initWithTexture:(SKTexture *)texture
{
    if (self = [super initWithTexture:texture]) {
        self.type = kObjectTypeRunner;
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:texture.size];
        self.physicsBody.categoryBitMask = kObjectCategoryRunner;
        self.physicsBody.collisionBitMask = 0;
        self.physicsBody.contactTestBitMask = kObjectCategoryHole | kObjectCategoryBarrier;
        self.physicsBody.usesPreciseCollisionDetection = YES;
        self.physicsBody.dynamic = YES;
        self.physicsBody.affectedByGravity = NO;
        self.isJumping = NO;
        self.isOnScreen = YES;
    }
    return self;
}

@end
