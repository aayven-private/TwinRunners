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
#import "Ground.h"
#import "ParallaxBG.h"
#import "CommonTools.h"

@interface GameScene()

@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;

@property (nonatomic) Runner *runner1;
@property (nonatomic) Runner *runner2;

@property (nonatomic) ContactManager *contactManager;
@property (nonatomic) ParallaxBG *parallaxBG;

@property (nonatomic) SKTexture *runnerTexture;
@property (nonatomic) SKTexture *barrierTexture;
@property (nonatomic) SKTexture *holeTexture;

@property (nonatomic) NSTimeInterval spawnInterval;
@property (nonatomic) NSTimeInterval lastSpawnInterval;

@property (nonatomic) int runner1Position;
@property (nonatomic) int runner2Position;

@property (nonatomic) BOOL isRunning;

@end

@implementation GameScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        self.runnerTexture = [SKTexture textureWithImageNamed:@"square"];
        self.barrierTexture = [SKTexture textureWithImageNamed:@"barrier"];
        self.holeTexture = [SKTexture textureWithImageNamed:@"hole"];
        self.isRunning = YES;
        self.spawnInterval = 1.2f;
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
    
    self.runner1Position = 1;
    self.runner2Position = 1;
    
    [self.view addGestureRecognizer:swipeLeftGestureRecognizer];
    [self.view addGestureRecognizer:swipeRightGestureRecognizer];
    [self.view addGestureRecognizer:tapRecognizer];
    
    /*NSArray *imageNames = @[@"background"];
    ParallaxBG * parallax = [[ParallaxBG alloc] initWithBackgrounds:imageNames size:self.size direction:kPBParallaxBackgroundDirectionDown fastestSpeed:kParallaxBGSpeed_gameScene andSpeedDecrease:kPBParallaxBackgroundDefaultSpeedDifferential];
    parallax.showBgStatus = NO;
    self.parallaxBG = parallax;
    [self addChild:parallax];*/
    
    SKShapeNode *divider = [SKShapeNode node];
    CGMutablePathRef pathToDraw = CGPathCreateMutable();
    CGPathMoveToPoint(pathToDraw, NULL, self.size.width / 2.0, self.size.height);
    CGPathAddLineToPoint(pathToDraw, NULL, self.size.width / 2.0, 0);
    divider.path = pathToDraw;
    [divider setStrokeColor:[UIColor blackColor]];
    [self addChild:divider];
    CGPathRelease(pathToDraw);
    
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
    
    self.runner1 = [[Runner alloc] initWithTexture:self.runnerTexture];
    self.runner1.position = CGPointMake(self.size.width / 4.0, 80);
    [self addChild:self.runner1];
    self.runner2 = [[Runner alloc] initWithTexture:self.runnerTexture];
    self.runner2.position = CGPointMake(self.size.width * 3.0 / 4.0, 80);
    [self addChild:self.runner2];
    
    
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
            [self addRandomObstacle];
        }
    }
}

-(void)addRandomObstacle
{
    GameObject *obstacle1, *obstacle2;
    int obstacleType1 = [CommonTools getRandomNumberFromInt:0 toInt:1];
    int obstacleType2 = [CommonTools getRandomNumberFromInt:0 toInt:1];
    
    int obstaclePlace1 = [CommonTools getRandomNumberFromInt:1 toInt:3];
    int obstaclePlace2 = [CommonTools getRandomNumberFromInt:5 toInt:7];
    
    switch (obstacleType1) {
        case 0: {
            obstacle1 = [[Barrier alloc] initWithTexture:self.barrierTexture];
        } break;
        case 1: {
            obstacle1 = [[Hole alloc] initWithTexture:self.holeTexture];
        } break;
    }
    
    switch (obstacleType2) {
        case 0: {
            obstacle2 = [[Barrier alloc] initWithTexture:self.barrierTexture];
        } break;
        case 1: {
            obstacle2 = [[Hole alloc] initWithTexture:self.holeTexture];
        } break;
    }
    
    obstacle1.position = CGPointMake(obstaclePlace1 * self.size.width / 8.0, self.size.height + obstacle1.size.height / 2.0);
    obstacle2.position = CGPointMake(obstaclePlace2 * self.size.width / 8.0, self.size.height + obstacle1.size.height / 2.0);
    
    SKAction *moveAction = [SKAction sequence:@[[SKAction moveToY:-obstacle1.size.height / 2.0 duration:3], [SKAction removeFromParent]]];
    
    [obstacle1 runAction:moveAction];
    [obstacle2 runAction:moveAction];
    
    [self addChild:obstacle1];
    [self addChild:obstacle2];
}

-(void)moveLeft:(UISwipeGestureRecognizer *)recognizer
{
    switch (_runner1Position) {
        case 0: {
            
        } break;
        case 1: {
            _runner1Position = 0;
            [_runner1 runAction:[SKAction moveToX:self.size.width / 8.0 duration:.1]];
        } break;
        case 2: {
            _runner1Position = 1;
            [_runner1 runAction:[SKAction moveToX:self.size.width / 4.0 duration:.1]];
        } break;
        default: break;
    }
    
    switch (_runner2Position) {
        case 0: {
            
        } break;
        case 1: {
            _runner2Position = 0;
            [_runner2 runAction:[SKAction moveToX:self.size.width * 5.0 / 8.0 duration:.1]];
        } break;
        case 2: {
            _runner2Position = 1;
            [_runner2 runAction:[SKAction moveToX:self.size.width * 3.0 / 4.0 duration:.1]];
        } break;
        default: break;
    }
}

-(void)moveRight:(UISwipeGestureRecognizer *)recognizer
{
    switch (_runner1Position) {
        case 0: {
            _runner1Position = 1;
            [_runner1 runAction:[SKAction moveToX:self.size.width / 4.0 duration:.05]];
        } break;
        case 1: {
            _runner1Position = 2;
            [_runner1 runAction:[SKAction moveToX:self.size.width * 3.0 / 8.0 duration:.05]];
        } break;
        case 2: {
            
        } break;
        default: break;
    }
    
    switch (_runner2Position) {
        case 0: {
            _runner2Position = 1;
            [_runner2 runAction:[SKAction moveToX:self.size.width * 3.0 / 4.0 duration:.05]];
        } break;
        case 1: {
            _runner2Position = 2;
            [_runner2 runAction:[SKAction moveToX:self.size.width * 7.0 / 8.0 duration:.05]];
        } break;
        case 2: {
            
        } break;
        default: break;
    }
}

-(void)jump:(UITapGestureRecognizer *)recognizer
{
    if (!_runner1.isJumping && !_runner2.isJumping) {
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

-(void)runner:(Runner *)runner CollidedWithBarrier:(Barrier *)barrier
{
    _isRunning = NO;
    NSLog(@"Game over - barrier");
    for (SKSpriteNode *node in self.children) {
        [node removeAllActions];
    }
    
}

-(void)runner:(Runner *)runner CollidedWithHole:(Hole *)hole
{
    if (!runner.isJumping) {
        _isRunning = NO;
        NSLog(@"Game over - hole");
        for (SKSpriteNode *node in self.children) {
            [node removeAllActions];
        }
        SKAction *shrinkAction = [SKAction scaleTo:0.1 duration:.3];
        SKAction *moveAction = [SKAction moveToY:hole.position.y duration:.3];
        SKAction *rotation = [SKAction rotateByAngle: M_PI duration:.3];
        [runner runAction:[SKAction group:@[shrinkAction, moveAction, rotation]]];
    }
}

@end
