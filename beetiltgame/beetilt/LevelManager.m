//
//  LevelManager.m
//  twinrunners
//
//  Created by Ivan Borsa on 04/06/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import "LevelManager.h"

@implementation LevelManager

-(NSArray *)loadLevelWithIndex:(int)index
{
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"level%d", index] ofType:@"plist"];
    NSArray *level = [NSArray arrayWithContentsOfFile:path];
    return level;
}

@end
