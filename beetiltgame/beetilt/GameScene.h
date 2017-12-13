//
//  GameScene.h
//  beetilt
//
//  Created by Ivan Borsa on 22/04/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ContactManager.h"
#import "GameSceneHandlerDelegate.h"

@interface GameScene : SKScene<ContactManagerDelegate>

@property (nonatomic, weak) id<GameSceneHandlerDelegate> gameDelegate;

-(void)initEnvironment;

@end
