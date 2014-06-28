//
//  LevelPreview.m
//  twinrunners
//
//  Created by Ivan Borsa on 28/06/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import "LevelPreview.h"
#import "Constants.h"

@implementation LevelPreview

-(id)initWithTexture:(SKTexture *)texture
{
    if (self = [super initWithTexture:texture]) {
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:texture.size];
        self.physicsBody.categoryBitMask = 0;
        self.physicsBody.collisionBitMask = 0;
        self.physicsBody.contactTestBitMask = 0;
        self.physicsBody.usesPreciseCollisionDetection = NO;
        self.physicsBody.dynamic = NO;
        self.physicsBody.affectedByGravity = NO;
    }
    return self;
}

@end
