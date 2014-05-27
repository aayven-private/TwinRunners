//
//  GameSceneHandlerDelegate.h
//  twinrunners
//
//  Created by Ivan Borsa on 20/05/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GameSceneHandlerDelegate <NSObject>

-(void)gameOverWithScore:(int)score;
-(void)retry;
-(void)quit;
-(void)scoreChanged:(int)newScore;

@end
