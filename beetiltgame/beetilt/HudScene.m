//
//  HudScene.m
//  twinrunners
//
//  Created by Ivan Borsa on 27/05/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import "HudScene.h"

@interface HudScene()

@property (nonatomic) SKLabelNode *scoreLabel;

@end

@implementation HudScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        self.scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        self.scoreLabel.fontSize = 16;
        self.scoreLabel.text = @"0";
        self.scoreLabel.fontColor = [UIColor blackColor];
        [self addChild:self.scoreLabel];
    }
    return self;
}

-(void)initHud
{
    self.scoreLabel.position = CGPointMake(self.size.width - 40, 10);
}

-(void)showScore:(int)score
{
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", score];
}

@end
