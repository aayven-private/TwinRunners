//
//  LevelPreview.h
//  twinrunners
//
//  Created by Ivan Borsa on 28/06/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface LevelPreview : SKSpriteNode

@property (nonatomic) int levelIndex;
@property (nonatomic) int levelScore;
@property (nonatomic) NSString *levelName;
@property (nonatomic) BOOL isLocked;

@end
