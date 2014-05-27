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
#import "Shifter.h"

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
    Runner *runner;
    GameObject *other;
    if (contact.bodyA.categoryBitMask == kObjectCategoryRunner) {
        runner = (Runner *)contact.bodyA.node;
        other = (GameObject *)contact.bodyB.node;
    }
    if (contact.bodyB.categoryBitMask == kObjectCategoryRunner) {
        runner = (Runner *)contact.bodyB.node;
        other = (GameObject *)contact.bodyA.node;
    }
    
    if ([other isKindOfClass:[Barrier class]]) {
        [_delegate runner:runner collidedWithBarrier:(Barrier *)other];
    } else if ([other isKindOfClass:[Hole class]]) {
        [_delegate runner:runner collidedWithHole:(Hole *)other];
    } else if ([other isKindOfClass:[Shifter class]]) {
        [_delegate runner:runner collidedWithShifter:(Shifter *)other];
    }
    
    /*if (contact.bodyA.categoryBitMask == kObjectCategoryBarrier) {
        if (contact.bodyB.categoryBitMask == kObjectCategoryRunner) {
            [_delegate runner:(Runner *)contact.bodyB.node CollidedWithBarrier:(Barrier *)contact.bodyA.node];
        }
    }
    if (contact.bodyB.categoryBitMask == kObjectCategoryBarrier) {
        if (contact.bodyA.categoryBitMask == kObjectCategoryRunner) {
            [_delegate runner:(Runner *)contact.bodyA.node CollidedWithBarrier:(Barrier *)contact.bodyB.node];
        }
    }
    if (contact.bodyA.categoryBitMask == kObjectCategoryHole) {
        if (contact.bodyB.categoryBitMask == kObjectCategoryRunner) {
            [_delegate runner:(Runner *)contact.bodyB.node CollidedWithHole:(Hole *)contact.bodyA.node];
        }
    }
    if (contact.bodyB.categoryBitMask == kObjectCategoryHole) {
        if (contact.bodyA.categoryBitMask == kObjectCategoryRunner) {
            [_delegate runner:(Runner *)contact.bodyA.node CollidedWithHole:(Hole *)contact.bodyB.node];
        }
    }
    if (contact.bodyA.categoryBitMask == kObjectCategoryShifter) {
        if (contact.bodyB.categoryBitMask == kObjectCategoryRunner) {
            [_delegate runner:(Runner *)contact.bodyB.node CollidedWithHole:(Hole *)contact.bodyA.node];
        }
    }
    if (contact.bodyB.categoryBitMask == kObjectCategoryShifter) {
        if (contact.bodyA.categoryBitMask == kObjectCategoryRunner) {
            [_delegate runner:(Runner *)contact.bodyA.node CollidedWithHole:(Hole *)contact.bodyB.node];
        }
    }*/
}

-(void)didEndContact:(SKPhysicsContact *)contact
{
    
}

@end
