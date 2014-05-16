//
//  Ground.m
//  twinrunners
//
//  Created by Ivan Borsa on 16/05/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import "Ground.h"

@implementation Ground

-(id)initWithTexture:(SKTexture *)texture
{
    if (self = [super initWithTexture:texture]) {
        self.type = kObjectTypeGround;
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:texture.size];
        self.physicsBody.categoryBitMask = kObjectCategoryGround;
        self.physicsBody.collisionBitMask = 0;
        self.physicsBody.contactTestBitMask = kObjectCategoryFrame;
        self.physicsBody.usesPreciseCollisionDetection = YES;
        self.physicsBody.dynamic = YES;
        self.physicsBody.affectedByGravity = NO;
        self.isOnScreen = NO;
    }
    return self;
}

@end
