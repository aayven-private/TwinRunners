//
//  LevelManager.h
//  twinrunners
//
//  Created by Ivan Borsa on 04/06/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Level.h"

@interface LevelManager : NSObject

-(Level *)loadLevelWithIndex:(int)index;

@end
