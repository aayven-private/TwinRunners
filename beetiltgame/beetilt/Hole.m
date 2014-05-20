//
//  Hole.m
//  twinrunners
//
//  Created by Ivan Borsa on 16/05/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import "Hole.h"

@implementation Hole

-(id)initWithTexture:(SKTexture *)texture
{
    if (self = [super initWithTexture:texture]) {
        self.type = kObjectTypeHole;
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:texture.size.width / 3.0f];
        self.physicsBody.categoryBitMask = kObjectCategoryHole;
        self.physicsBody.collisionBitMask = 0;
        self.physicsBody.contactTestBitMask = kObjectCategoryRunner | kObjectCategoryFrame;
        self.physicsBody.usesPreciseCollisionDetection = YES;
        self.physicsBody.dynamic = YES;
        self.physicsBody.affectedByGravity = NO;
        self.isOnScreen = NO;
    }
    return self;
}

@end
