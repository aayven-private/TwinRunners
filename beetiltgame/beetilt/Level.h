//
//  Level.h
//  twinrunners
//
//  Created by Ivan Borsa on 06/06/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Level : NSObject

-(id)initWithRows:(NSArray *)rows andTiming:(float)timing;

@property (nonatomic) NSArray *rows;
@property (nonatomic) float timing;

@end
