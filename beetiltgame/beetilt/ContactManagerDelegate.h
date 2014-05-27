//
//  ContactManagerDelegate.h
//  twinrunners
//
//  Created by Ivan Borsa on 16/05/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Runner.h"
#import "Barrier.h"
#import "Hole.h"
#import "Shifter.h"

@protocol ContactManagerDelegate <NSObject>

-(void)runner:(Runner *)runner collidedWithBarrier:(Barrier *)barrier;
-(void)runner:(Runner *)runner collidedWithHole:(Hole *)hole;
-(void)runner:(Runner *)runner collidedWithShifter:(Shifter *)shifter;
-(void)invertDirections;

@end
