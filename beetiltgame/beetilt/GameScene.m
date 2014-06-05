//
//  GameScene.m
//  beetilt
//
//  Created by Ivan Borsa on 22/04/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import "GameScene.h"
#import "Runner.h"
#import "Barrier.h"
#import "Hole.h"
#import "Shifter.h"
#import "Inverter.h"
#import "ParallaxBG.h"
#import "CommonTools.h"
#import "LevelManager.h"

@interface GameScene()

@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;

@property (nonatomic) SKSpriteNode *plane1;
@property (nonatomic) SKSpriteNode *plane2;

@property (nonatomic) Runner *runner1;
@property (nonatomic) Runner *runner2;

@property (nonatomic) ContactManager *contactManager;
@property (nonatomic) ParallaxBG *parallaxBG;

@property (nonatomic) SKTexture *runnerTexture;
@property (nonatomic) SKTexture *barrierTexture;
@property (nonatomic) SKTexture *holeTexture;
@property (nonatomic) SKTexture *shifterTexture;
@property (nonatomic) SKTexture *inverterTexture;

@property (nonatomic) NSTimeInterval spawnInterval;
@property (nonatomic) NSTimeInterval lastSpawnInterval;

@property (nonatomic) NSTimeInterval spawnInterval_bonus;
@property (nonatomic) NSTimeInterval lastSpawnInterval_bonus;

@property (nonatomic) BOOL isRunning;
@property (nonatomic) BOOL isinverted;

@property (nonatomic) SKSpriteNode *hud;
@property (nonatomic) SKSpriteNode *inverterIcon;

@property (nonatomic) int score;

@property (nonatomic) SKAction *moveAction;
@property (nonatomic) LevelManager *levelManager;

@property (nonatomic) NSArray *currentLevel;
@property (nonatomic) NSEnumerator *levelEnumerator;

@property (nonatomic) BOOL isAdventureMode;

@end

@implementation GameScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        self.runnerTexture = [SKTexture textureWithImageNamed:@"square"];
        self.barrierTexture = [SKTexture textureWithImageNamed:@"barrier"];
        self.holeTexture = [SKTexture textureWithImageNamed:@"hole"];
        self.shifterTexture = [SKTexture textureWithImageNamed:@"triangle"];
        self.inverterTexture = [SKTexture textureWithImageNamed:@"inverter"];
        
        self.moveAction = [SKAction sequence:@[[SKAction moveToY:-self.barrierTexture.size.height / 2.0 duration:2],[SKAction removeFromParent]]];
        
        self.isRunning = YES;
        self.spawnInterval = 1.1f;
        self.spawnInterval_bonus = 1.8f;
        self.isinverted = NO;
        
        self.score = 0;
        
        self.isAdventureMode = NO;
        
        if (self.isAdventureMode) {
            self.levelManager = [[LevelManager alloc] init];
            self.currentLevel = [self.levelManager loadLevelWithIndex:1];
            self.levelEnumerator = self.currentLevel.objectEnumerator;
        }
    }
    return self;
}

-(void)initEnvironment
{
    [self removeAllChildren];
    
    UISwipeGestureRecognizer* swipeLeftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(moveLeft:)];
    swipeLeftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer* swipeRightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(moveRight:)];
    swipeRightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jump:)];
    
    [self.view addGestureRecognizer:swipeLeftGestureRecognizer];
    [self.view addGestureRecognizer:swipeRightGestureRecognizer];
    [self.view addGestureRecognizer:tapRecognizer];
    
    /*NSArray *imageNames = @[@"background"];
    ParallaxBG * parallax = [[ParallaxBG alloc] initWithBackgrounds:imageNames size:self.size direction:kPBParallaxBackgroundDirectionDown fastestSpeed:kParallaxBGSpeed_gameScene andSpeedDecrease:kPBParallaxBackgroundDefaultSpeedDifferential];
    parallax.showBgStatus = NO;
    self.parallaxBG = parallax;
    [self addChild:parallax];*/
    
    self.contactManager = [[ContactManager alloc] initWithDelegate:self];
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsWorld.contactDelegate = self.contactManager;
    self.physicsBody.categoryBitMask = kObjectCategoryFrame;
    self.physicsBody.contactTestBitMask = kObjectCategoryBarrier | kObjectCategoryGround | kObjectCategoryHole;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.friction = 0.0f;
    self.physicsBody.restitution = 0.0f;
    self.physicsBody.usesPreciseCollisionDetection = YES;
    self.scaleMode = SKSceneScaleModeAspectFill;
    
    self.plane1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(self.size.width / 2.0, self.size.height)];
    self.plane1.position = CGPointMake(0, 0);
    
    self.plane2 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(self.size.width / 2.0, self.size.height)];
    self.plane2.position = CGPointMake(self.size.width / 2.0, 0);
    
    [self addChild:self.plane1];
    [self addChild:self.plane2];
    
    self.runner1 = [[Runner alloc] initWithTexture:self.runnerTexture];
    self.runner1.position = CGPointMake(self.plane1.size.width / 2.0, 80);
    
    [self.plane1 addChild:self.runner1];
    self.runner2 = [[Runner alloc] initWithTexture:self.runnerTexture];
    self.runner2.position = CGPointMake(self.plane2.size.width / 2.0, 80);
    [self.plane2 addChild:self.runner2];
    
    self.runner1.lane = 1;
    self.runner2.lane = 1;
    
    for (int i=1; i<3; i++) {
        SKShapeNode *divider1 = [SKShapeNode node];
        CGMutablePathRef pathToDraw = CGPathCreateMutable();
        CGPathMoveToPoint(pathToDraw, NULL, i * self.plane1.size.width / 3.0, self.plane1.size.height);
        CGPathAddLineToPoint(pathToDraw, NULL, i * self.plane1.size.width / 3.0, 0);
        divider1.lineWidth = 0.5;
        divider1.path = pathToDraw;
        [divider1 setStrokeColor:[UIColor lightGrayColor]];
        [self.plane1 addChild:divider1];
        CGPathRelease(pathToDraw);
        
        SKShapeNode *divider2 = [SKShapeNode node];
        pathToDraw = CGPathCreateMutable();
        CGPathMoveToPoint(pathToDraw, NULL, i * self.plane2.size.width / 3.0, self.plane2.size.height);
        CGPathAddLineToPoint(pathToDraw, NULL, i * self.plane2.size.width / 3.0, 0);
        divider2.lineWidth = 0.5;
        divider2.path = pathToDraw;
        [divider2 setStrokeColor:[UIColor lightGrayColor]];
        [self.plane2 addChild:divider2];
        CGPathRelease(pathToDraw);
    }
    
    SKShapeNode *topLine = [SKShapeNode node];
    CGMutablePathRef pathToDraw = CGPathCreateMutable();
    CGPathMoveToPoint(pathToDraw, NULL, 0, self.size.height);
    CGPathAddLineToPoint(pathToDraw, NULL, self.size.width, self.size.height);
    topLine.lineWidth = 1.5;
    topLine.path = pathToDraw;
    [topLine setStrokeColor:[UIColor blackColor]];
    [self addChild:topLine];
    CGPathRelease(pathToDraw);
    
    SKShapeNode *divider = [SKShapeNode node];
    pathToDraw = CGPathCreateMutable();
    CGPathMoveToPoint(pathToDraw, NULL, self.size.width / 2.0, self.size.height);
    CGPathAddLineToPoint(pathToDraw, NULL, self.size.width / 2.0, 0);
    divider.path = pathToDraw;
    [divider setStrokeColor:[UIColor blackColor]];
    [self addChild:divider];
    CGPathRelease(pathToDraw);
}

- (void)update:(NSTimeInterval)currentTime
{
    CFTimeInterval timeSinceLast = currentTime - _lastUpdateTimeInterval;
    if (timeSinceLast > 1) { // more than a second since last update
        timeSinceLast = 1.0 / 60.0;
    }
    _lastUpdateTimeInterval = currentTime;
    [self updateWithTimeSinceLastUpdate:timeSinceLast];
}

- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast
{
    if (_isRunning) {
        _lastSpawnInterval += timeSinceLast;
        if (_lastSpawnInterval > _spawnInterval) {
            _lastSpawnInterval = 0;
            if (!self.isAdventureMode) {
                [self addRandomBarrier];
            } else {
                [self addNextLevelRow];
            }
        }
        
        _lastSpawnInterval_bonus += timeSinceLast;
        if (_lastSpawnInterval_bonus > _spawnInterval_bonus) {
            _lastSpawnInterval_bonus = 0;
            _spawnInterval_bonus = 1.2f;
            if (!self.isAdventureMode) {
                [self addRandomBonus];
            }
        }
    }
}

-(void)addNextLevelRow
{
    NSArray *nextRow = [_levelEnumerator nextObject];
    if (!nextRow) {
        _levelEnumerator = _currentLevel.objectEnumerator;
        nextRow = _levelEnumerator.nextObject;
    }
    
    NSMutableArray *obstacles_plane1 = [NSMutableArray array], *obstacles_plane2 = [NSMutableArray array];
    for (int i=0; i<3; i++) {
        NSString *obstacleType = [nextRow objectAtIndex:i];
        GameObject *obstacle;
        int lane = i;
        if ([obstacleType isEqualToString:@"b"]) {
            obstacle = [[Barrier alloc] initWithTexture:self.barrierTexture];
        } else if ([obstacleType isEqualToString:@"h"]) {
            obstacle = [[Hole alloc] initWithTexture:self.holeTexture];
        } else {
            obstacle = nil;
        }
        
        if (obstacle) {
            obstacle.lane = lane;
            obstacle.position = CGPointMake((lane * 2.0 / 6.0 + 1.0 / 6.0) * self.plane1.size.width, self.plane1.size.height + obstacle.size.height / 2.0);
            [obstacle runAction:_moveAction];
            [obstacles_plane1 addObject:obstacle];
        }
    }
    
    for (int i=3; i<6; i++) {
        NSString *obstacleType = [nextRow objectAtIndex:i];
        GameObject *obstacle;
        int lane = i - 3;
        if ([obstacleType isEqualToString:@"b"]) {
            obstacle = [[Barrier alloc] initWithTexture:self.barrierTexture];
        } else if ([obstacleType isEqualToString:@"h"]) {
            obstacle = [[Hole alloc] initWithTexture:self.holeTexture];
        } else {
            obstacle = nil;
        }
        
        if (obstacle) {
            obstacle.lane = lane;
            obstacle.position = CGPointMake((lane * 2.0 / 6.0 + 1.0 / 6.0) * self.plane2.size.width, self.plane2.size.height + obstacle.size.height / 2.0);
            [obstacle runAction:_moveAction];
            [obstacles_plane2 addObject:obstacle];
        }
    }
    
    for (GameObject *obstacle in obstacles_plane1) {
        [self.plane1 addChild:obstacle];
    }
    
    for (GameObject *obstacle in obstacles_plane2) {
        [self.plane2 addChild:obstacle];
    }
}

-(void)addRandomBarrier
{
    NSMutableArray *obstacles_plane1 = [NSMutableArray array], *obstacles_plane2 = [NSMutableArray array];
    
    int freeLane = [CommonTools getRandomNumberFromInt:0 toInt:2];
    NSNumber *freeLaneIndex = [NSNumber numberWithInt:freeLane];
    
    int obstacleCountLane1 = [CommonTools getRandomNumberFromInt:1 toInt:1];
    int obstacleCountLane2 = [CommonTools getRandomNumberFromInt:1 toInt:1];
    
    NSMutableArray *possibleLaneIndices = [NSMutableArray arrayWithArray:@[@0, @1, @2]];
    [possibleLaneIndices removeObject:freeLaneIndex];
    
    for (int i=0; i<obstacleCountLane1; i++) {
        GameObject *obstacle;
        NSNumber *lane = [CommonTools getRandomElementFromArray:possibleLaneIndices];
        int obstacleType = [CommonTools getRandomNumberFromInt:0 toInt:1];
        
        switch (obstacleType) {
            case 0: {
                obstacle = [[Barrier alloc] initWithTexture:self.barrierTexture];
            } break;
            case 1: {
                obstacle = [[Hole alloc] initWithTexture:self.holeTexture];
            } break;
        }
        obstacle.lane = lane.intValue;
        obstacle.position = CGPointMake((lane.intValue * 2.0 / 6.0 + 1.0 / 6.0) * self.plane1.size.width, self.plane1.size.height + obstacle.size.height / 2.0);
        
        [obstacle runAction:_moveAction];
        [obstacles_plane1 addObject:obstacle];
        
        [possibleLaneIndices removeObject:lane];
    }
    
    possibleLaneIndices = [NSMutableArray arrayWithArray:@[@0, @1, @2]];
    [possibleLaneIndices removeObject:freeLaneIndex];
    
    for (int i=0; i<obstacleCountLane2; i++) {
        GameObject *obstacle;
        NSNumber *lane = [CommonTools getRandomElementFromArray:possibleLaneIndices];
        int obstacleType = [CommonTools getRandomNumberFromInt:0 toInt:1];
        
        switch (obstacleType) {
            case 0: {
                obstacle = [[Barrier alloc] initWithTexture:self.barrierTexture];
            } break;
            case 1: {
                obstacle = [[Hole alloc] initWithTexture:self.holeTexture];
            } break;
        }
        obstacle.lane = lane.intValue;
        obstacle.position = CGPointMake((lane.intValue * 2.0 / 6.0 + 1.0 / 6.0) * self.plane2.size.width, self.plane2.size.height + obstacle.size.height / 2.0);
        
        [obstacle runAction:_moveAction];
        [obstacles_plane2 addObject:obstacle];
        
        [possibleLaneIndices removeObject:lane];
    }
    
    for (GameObject *obstacle in obstacles_plane1) {
        [self.plane1 addChild:obstacle];
    }
    
    for (GameObject *obstacle in obstacles_plane2) {
        [self.plane2 addChild:obstacle];
    }
}

-(void)addRandomBonus
{
    int planeIndex = [CommonTools getRandomNumberFromInt:0 toInt:1];
    int laneIndex = [CommonTools getRandomNumberFromInt:0 toInt:2];
    GameObject *bonus;
    int bonusType = [CommonTools getRandomNumberFromInt:0 toInt:1];
    switch (bonusType) {
        case 0: {
            bonus = [[Shifter alloc] initWithTexture:self.shifterTexture];
            if (laneIndex == 0) {
                ((Shifter *)bonus).shiftDirection = kDirectionRight;
            } else if (laneIndex == 2) {
                ((Shifter *)bonus).shiftDirection = kDirectionLeft;
            }
        } break;
        case 1: {
            bonus = [[Inverter alloc] initWithTexture:self.inverterTexture];
        } break;
    }
    
    bonus.position = CGPointMake((laneIndex * 2.0 / 6.0 + 1.0 / 6.0) * self.plane1.size.width, self.plane1.size.height + bonus.size.height / 2.0);
    [bonus runAction:_moveAction];
    
    switch (planeIndex) {
        case 0: {
            [self.plane1 addChild:bonus];
        } break;
        case 1: {
            [self.plane2 addChild:bonus];
        } break;
    }
}

/*-(void)addRandomObstacle
{
    GameObject *obstacle1, *obstacle2;
    int obstacleType1 = [CommonTools getRandomNumberFromInt:0 toInt:3];
    int obstacleType2 = [CommonTools getRandomNumberFromInt:0 toInt:3];
    
    int obstacleLane1 = [CommonTools getRandomNumberFromInt:0 toInt:2];
    int obstacleLane2 = [CommonTools getRandomNumberFromInt:0 toInt:2];
    
    switch (obstacleType1) {
        case 0: {
            obstacle1 = [[Barrier alloc] initWithTexture:self.barrierTexture];
        } break;
        case 1: {
            obstacle1 = [[Hole alloc] initWithTexture:self.holeTexture];
        } break;
        case 2: {
            obstacle1 = [[Shifter alloc] initWithTexture:self.shifterTexture];
            if (obstacleLane1 == 0) {
                ((Shifter *)obstacle1).shiftDirection = kDirectionRight;
            } else if (obstacleLane1 == 2) {
                ((Shifter *)obstacle1).shiftDirection = kDirectionLeft;
            }
        } break;
        case 3: {
            obstacle1 = [[Inverter alloc] initWithTexture:self.inverterTexture];
        } break;
    }
    
    switch (obstacleType2) {
        case 0: {
            obstacle2 = [[Barrier alloc] initWithTexture:self.barrierTexture];
        } break;
        case 1: {
            obstacle2 = [[Hole alloc] initWithTexture:self.holeTexture];
        } break;
        case 2: {
            obstacle2 = [[Shifter alloc] initWithTexture:self.shifterTexture];
            if (obstacleLane2 == 0) {
                ((Shifter *)obstacle2).shiftDirection = kDirectionRight;
            } else if (obstacleLane2 == 2) {
                ((Shifter *)obstacle2).shiftDirection = kDirectionLeft;
            }
        } break;
        case 3: {
            obstacle2 = [[Inverter alloc] initWithTexture:self.inverterTexture];
        } break;
    }
    
    obstacle1.position = CGPointMake((obstacleLane1 * 2.0 / 6.0 + 1.0 / 6.0) * self.plane1.size.width, self.plane1.size.height + obstacle1.size.height / 2.0);
    obstacle2.position = CGPointMake((obstacleLane2 * 2.0 / 6.0 + 1.0 / 6.0) * self.plane2.size.width, self.plane2.size.height + obstacle1.size.height / 2.0);
    
    obstacle1.lane = obstacleLane1;
    obstacle2.lane = obstacleLane2;
    
    SKAction *moveAction1 = [SKAction sequence:@[[SKAction moveToY:-obstacle1.size.height / 2.0 duration:2], [SKAction runBlock:^{
        _score += obstacle1.objectValue;
        [_delegate scoreChanged:_score];
    }],[SKAction removeFromParent]]];
    
    SKAction *moveAction2 = [SKAction sequence:@[[SKAction moveToY:-obstacle1.size.height / 2.0 duration:2], [SKAction runBlock:^{
        _score += obstacle2.objectValue;
        [_delegate scoreChanged:_score];
    }],[SKAction removeFromParent]]];
    
    [obstacle1 runAction:moveAction1];
    [obstacle2 runAction:moveAction2];
    
    [self.plane1 addChild:obstacle1];
    [self.plane2 addChild:obstacle2];
}*/

-(void)moveLeft:(UISwipeGestureRecognizer *)recognizer
{
    if (_isRunning) {
        if (!_isinverted) {
            [self moveRunner:_runner1 inDirection:kDirectionLeft];
            [self moveRunner:_runner2 inDirection:kDirectionLeft];
        } else {
            [self moveRunner:_runner1 inDirection:kDirectionRight];
            [self moveRunner:_runner2 inDirection:kDirectionRight];
        }
    }
}

-(void)moveRight:(UISwipeGestureRecognizer *)recognizer
{
    if (_isRunning) {
        if (!_isinverted) {
            [self moveRunner:_runner1 inDirection:kDirectionRight];
            [self moveRunner:_runner2 inDirection:kDirectionRight];
        } else {
            [self moveRunner:_runner1 inDirection:kDirectionLeft];
            [self moveRunner:_runner2 inDirection:kDirectionLeft];
        }
    }
}

-(void)moveRunner:(Runner *)runner inDirection:(Direction)direction
{
    switch (direction) {
        case kDirectionLeft: {
            switch (runner.lane) {
                case 0: {
                    
                } break;
                case 1: {
                    runner.lane = 0;
                    [runner runAction:[SKAction moveToX:self.plane1.size.width / 6.0 duration:.05]];
                } break;
                case 2: {
                    runner.lane = 1;
                    [runner runAction:[SKAction moveToX:self.plane1.size.width / 2.0 duration:.05]];
                } break;
                default: break;
            }
        } break;
        case kDirectionRight: {
            switch (runner.lane) {
                case 0: {
                    runner.lane = 1;
                    [runner runAction:[SKAction moveToX:self.plane1.size.width / 2.0 duration:.05]];
                } break;
                case 1: {
                    runner.lane = 2;
                    [runner runAction:[SKAction moveToX:self.plane1.size.width * 5.0 / 6.0 duration:.05]];
                } break;
                case 2: {
                    
                } break;
                default: break;
            }
        } break;
    }
}

-(void)jump:(UITapGestureRecognizer *)recognizer
{
    if (!_runner1.isJumping && !_runner2.isJumping && _isRunning) {
        _runner1.isJumping = YES;
        _runner2.isJumping = YES;
        SKAction *jumpAction = [SKAction sequence:@[[SKAction scaleTo:1.4 duration:.3], [SKAction scaleTo:1.0 duration:.3]]];
        [_runner1 runAction:[SKAction sequence:@[jumpAction, [SKAction runBlock:^{
            _runner1.isJumping = NO;
        }]]]];
        [_runner2 runAction:[SKAction sequence:@[jumpAction, [SKAction runBlock:^{
            _runner2.isJumping = NO;
        }]]]];
    }
}

-(void)runner:(Runner *)runner collidedWithBarrier:(Barrier *)barrier
{
    if (runner.lane == barrier.lane) {
        _isRunning = NO;
        NSLog(@"Game over - barrier");
        SKSpriteNode *ownerPlane;
        if ([runner isEqual:_runner1]) {
            ownerPlane = _plane1;
        } else {
            ownerPlane = _plane2;
        }
        for (SKSpriteNode *node in ownerPlane.children) {
            [node removeAllActions];
        }
        SKAction *showGOSAction = [SKAction sequence:@[[SKAction waitForDuration:1], [SKAction runBlock:^{
            [_delegate gameOverWithScore:0];
        }]]];
        
        [self runAction:showGOSAction];
    }
}

-(void)runner:(Runner *)runner collidedWithHole:(Hole *)hole
{
    if (!runner.isJumping && runner.lane == hole.lane) {
        _isRunning = NO;
        NSLog(@"Game over - hole");
        SKSpriteNode *ownerPlane;
        if ([runner isEqual:_runner1]) {
            ownerPlane = _plane1;
        } else {
            ownerPlane = _plane2;
        }
        for (SKSpriteNode *node in ownerPlane.children) {
            [node removeAllActions];
        }
        SKAction *shrinkAction = [SKAction scaleTo:0.1 duration:.3];
        SKAction *moveAction = [SKAction moveToY:hole.position.y duration:.3];
        SKAction *rotation = [SKAction rotateByAngle: M_PI duration:.3];
        [runner runAction:[SKAction group:@[shrinkAction, moveAction, rotation]]];
        
        SKAction *showGOSAction = [SKAction sequence:@[[SKAction waitForDuration:1], [SKAction runBlock:^{
            [_delegate gameOverWithScore:0];
        }]]];
        
        [self runAction:showGOSAction];
    }
}

-(void)runner:(Runner *)runner collidedWithShifter:(Shifter *)shifter
{
    if (runner.lane == shifter.lane) {
        [self moveRunner:runner inDirection:shifter.shiftDirection];
    }
}

-(void)invertDirections
{
    SKAction *invertAction = [SKAction sequence:@[[SKAction runBlock:^{
        self.isinverted = YES;
    }], [SKAction waitForDuration:5], [SKAction runBlock:^{
        self.isinverted = NO;
    }]]];
    [self runAction:invertAction];
}

-(void)setInverterIconHidden:(BOOL)isHidden
{
    
}

@end
