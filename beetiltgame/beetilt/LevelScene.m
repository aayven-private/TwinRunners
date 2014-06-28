//
//  LevelScene.m
//  twinrunners
//
//  Created by Ivan Borsa on 28/06/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import "LevelScene.h"
#import "LevelManager.h"
#import "LevelPreview.h"
#import "Constants.h"

@interface LevelScene()

@property (nonatomic) LevelManager *levelManager;

@property (nonatomic) int currentLevelIndex;
@property (nonatomic) int playerLevel;
@property (nonatomic) int maxLevelIndex;

@property (nonatomic) LevelPreview *currentPreview;
@property (nonatomic) LevelPreview *previousPreview;
@property (nonatomic) LevelPreview *nextPreview;

@end

@implementation LevelScene

-(id)initWithSize:(CGSize)size andCurrentLevelIndex:(int)levelIndex
{
    if (self = [super initWithSize:size]) {
        self.levelManager = [[LevelManager alloc] init];
        self.playerLevel = [self.levelManager getCurrentLevelIndex];
        self.currentLevelIndex = self.playerLevel;
    }
    return self;
}

-(void)initEnvironment
{
    UISwipeGestureRecognizer* swipeLeftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(loadPreviousPreview:)];
    swipeLeftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer* swipeRightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(loadNextPreview:)];
    swipeRightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startLevel:)];
    
    [self.view addGestureRecognizer:swipeLeftGestureRecognizer];
    [self.view addGestureRecognizer:swipeRightGestureRecognizer];
    [self.view addGestureRecognizer:tapRecognizer];
}

-(void)loadPreviousPreview:(UISwipeGestureRecognizer *)recognizer
{
    if (_currentLevelIndex > 1) {
        _currentLevelIndex--;
        [self updatePreviewsInDirection:kDirectionLeft];
    }
}

-(void)loadNextPreview:(UISwipeGestureRecognizer *)recognizer
{
    if (_currentLevelIndex < kMaxLevelIndex) {
        _currentLevelIndex++;
        [self updatePreviewsInDirection:kDirectionRight];
    }
}

-(void)startLevel:(UITapGestureRecognizer *)recognizer
{
    
}

-(void)updatePreviewsInDirection:(Direction)direction
{
    switch (direction) {
        case kDirectionLeft: {
            
        } break;
        case kDirectionRight: {
            
        } break;
        default: {
            
        } break;
    }
    
    /*UIImage *currentLevelImage = [_levelManager getLevelPreviewImageForLevelIndex:_currentLevelIndex];
    _currentPreview = [[LevelPreview alloc] initWithTexture:[SKTexture textureWithImage:currentLevelImage]];
    _currentPreview.levelIndex = self.playerLevel;
    
    UIImage *nextLevelImage = [_levelManager getLevelPreviewImageForLevelIndex:_currentLevelIndex + 1];
    if (nextLevelImage) {
        
    }
    
    if (_currentLevelIndex > 1) {
        UIImage *previousImage = [_levelManager getLevelPreviewImageForLevelIndex:_currentLevelIndex - 1];
        _previousPreview = [[LevelPreview alloc] initWithTexture:[SKTexture textureWithImage:previousImage]];
    } else {
        
    }*/
}

@end
