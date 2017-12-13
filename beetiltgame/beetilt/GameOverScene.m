//
//  GameOverScene.m
//  twinrunners
//
//  Created by Ivan Borsa on 20/05/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import "GameOverScene.h"

@interface GameOverScene()

@property (nonatomic) SKSpriteNode *exitButton;
@property (nonatomic) SKSpriteNode *retryButton;

@end

@implementation GameOverScene

-(id)initWithSize:(CGSize)size andScore:(int)score
{
    if (self = [super initWithSize:size]) {
        self.exitButton = [[SKSpriteNode alloc] initWithColor:[UIColor lightGrayColor] size:CGSizeMake(160, 80)];
        self.exitButton.position = CGPointMake(self.size.width / 2.0, self.size.height / 2.0);
        self.exitButton.name = @"exit";
        [self addChild:self.exitButton];
        
        SKLabelNode *exitLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        exitLabel.text = @"Menu";
        exitLabel.fontColor = [UIColor whiteColor];
        exitLabel.fontSize = 20.0;
        exitLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        exitLabel.position = self.exitButton.position;
        exitLabel.name = @"exit";
        [self addChild:exitLabel];
        
        self.retryButton = [[SKSpriteNode alloc] initWithColor:[UIColor lightGrayColor] size:CGSizeMake(160, 80)];
        self.retryButton.position = CGPointMake(self.size.width / 2.0, self.size.height / 2.0 - 90.0);
        self.retryButton.name = @"retry";
        [self addChild:self.retryButton];
        
        SKLabelNode *retryLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        retryLabel.text = @"Retry";
        retryLabel.fontColor = [UIColor whiteColor];
        retryLabel.fontSize = 20.0;
        retryLabel.position = self.retryButton.position;
        retryLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        retryLabel.name = @"retry";
        [self addChild:retryLabel];
    }
    return self;
}

-(void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonClicked:)];
    [self.view addGestureRecognizer:tgr];
}

-(void)buttonClicked:(UITapGestureRecognizer *)recognizer
{
    CGPoint loc = [recognizer locationInView:self.view];
    loc = CGPointMake(loc.x, self.size.height - loc.y);
    SKNode *node = [self nodeAtPoint:loc];
    
    if ([node.name isEqualToString:@"exit"]) {
        [_gameDelegate quit];
    } else if ([node.name isEqualToString:@"retry"]) {
        [_gameDelegate retry];
    }
}

@end
