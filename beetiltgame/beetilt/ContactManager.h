//
//  ContactManager.h
//  twinrunners
//
//  Created by Ivan Borsa on 16/05/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "ContactManagerDelegate.h"

@interface ContactManager : NSObject<SKPhysicsContactDelegate>

-(id)initWithDelegate:(id<ContactManagerDelegate>)delegate;

@end
