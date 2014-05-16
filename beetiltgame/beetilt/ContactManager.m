//
//  ContactManager.m
//  twinrunners
//
//  Created by Ivan Borsa on 16/05/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import "ContactManager.h"

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
    
}

-(void)didEndContact:(SKPhysicsContact *)contact
{
    
}

@end
