//
//  Inverter.m
//  twinrunners
//
//  Created by Ivan Borsa on 27/05/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import "Inverter.h"

@implementation Inverter

-(id)initWithTexture:(SKTexture *)texture
{
    if (self = [super initWithTexture:texture]) {
        self.type = kObjectTypeInverter;
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:texture.size];
        self.physicsBody.categoryBitMask = kObjectCategoryInverter;
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
