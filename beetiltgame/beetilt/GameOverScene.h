//
//  GameOverScene.h
//  twinrunners
//
//  Created by Ivan Borsa on 20/05/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameSceneHandlerDelegate.h"

@interface GameOverScene : SKScene

@property (nonatomic, weak) id<GameSceneHandlerDelegate> gameDelegate;

-(id)initWithSize:(CGSize)size andScore:(int)score;

@end
