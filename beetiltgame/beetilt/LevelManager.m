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

@end
