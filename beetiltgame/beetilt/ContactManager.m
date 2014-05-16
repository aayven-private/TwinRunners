//
//  ContactManager.m
//  twinrunners
//
//  Created by Ivan Borsa on 16/05/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import "ContactManager.h"
#import "Barrier.h"
#import "Hole.h"
#import "Ground.h"
#import "Runner.h"

@interface ContactManager()

@property (nonatomic, weak) id<ContactManagerDelegate> delegate;

@end

@implementation ContactManager

-(id)initWithDelegate:(id<ContactManagerDelegate>)delegate
{
    if (self = [super init]) {
        self.delegate = delegate;
    }
    return self;
}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    if (contact.bodyA.categoryBitMask == kObjectCategoryFrame) {
        if (contact.bodyB.categoryBitMask == kObjectCategoryGround || contact.bodyB.categoryBitMask == kObjectCategoryHole || contact.bodyB.categoryBitMask == kObjectCategoryBarrier) {
            GameObject *enteringObject = (GameObject *)contact.bodyB.node;
            if (!enteringObject.isOnScreen) {
                //enteringObject.isOnScreen = YES;
                [_delegate gameObjectEnteredScene:enteringObject];
            }
        }
    } else if (contact.bodyB.categoryBitMask == kObjectCategoryFrame) {
        if (contact.bodyA.categoryBitMask == kObjectCategoryGround || contact.bodyA.categoryBitMask == kObjectCategoryHole || contact.bodyA.categoryBitMask == kObjectCategoryBarrier) {
            GameObject *enteringObject = (GameObject *)contact.bodyA.node;
            if (!enteringObject.isOnScreen) {
                //enteringObject.isOnScreen = YES;
                [_delegate gameObjectEnteredScene:enteringObject];
            }
        }
    }
}

-(void)didEndContact:(SKPhysicsContact *)contact
{
    
}

@end
