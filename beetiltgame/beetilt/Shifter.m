//
//  Shifter.m
//  twinrunners
//
//  Created by Ivan Borsa on 27/05/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import "Shifter.h"
#import "CommonTools.h"

@implementation Shifter

-(id)initWithTexture:(SKTexture *)texture
{
    if (self = [super initWithTexture:texture]) {
        self.type = kObjectTypeShifter;
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:texture.size];
        self.physicsBody.categoryBitMask = kObjectCategoryShifter;
        self.physicsBody.collisionBitMask = 0;
        self.physicsBody.contactTestBitMask = kObjectCategoryRunner | kObjectCategoryFrame;
        self.physicsBody.usesPreciseCollisionDetection = YES;
        self.physicsBody.dynamic = YES;
        self.physicsBody.affectedByGravity = NO;
        self.isOnScreen = NO;
        self.shiftDirection = [CommonTools getRandomNumberFromInt:0 toInt:1];
    }
    return self;
}

@end
