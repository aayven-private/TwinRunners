//
//  LevelManager.m
//  twinrunners
//
//  Created by Ivan Borsa on 04/06/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import "LevelManager.h"
#import "Constants.h"

@implementation LevelManager

-(Level *)loadLevelWithIndex:(int)index
{
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"level%d", index] ofType:@"plist"];
    NSDictionary *levelDict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *rows = [levelDict objectForKey:kRowsKey];
    NSNumber *timing = [levelDict objectForKey:kTimingKey];
    Level *level = [[Level alloc] initWithRows:rows andTiming:timing.floatValue];
    return level;
}

-(int)getCurrentLevelIndex
{
    int levelIndex = 1;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *currentLevelIndex = [defaults objectForKey:kCurrentLevelIndexKey];
    if (currentLevelIndex) {
        levelIndex = currentLevelIndex.intValue;
    } else {
        [defaults setObject:[NSNumber numberWithInt:levelIndex] forKey:kCurrentLevelIndexKey];
        [defaults synchronize];
    }
    return levelIndex;
}

-(UIImage *)getLevelPreviewImageForLevelIndex:(int)index
{
    return [UIImage imageNamed:[NSString stringWithFormat:@"preview%d", index]];
}

@end
