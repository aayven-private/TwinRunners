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

@interface GameScene()

@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;

@property (nonatomic) Runner *runner1;
@property (nonatomic) Runner *runner2;

@property (nonatomic) ContactManager *contactManager;
@property (nonatomic) ParallaxBG *parallaxBG;

@property (nonatomic) SKTexture *runnerTexture;
@property (nonatomic) SKTexture *barrierTexture;
@property (nonatomic) SKTexture *groundTexture;

@property (nonatomic) NSTimeInterval spawnInterval;
@property (nonatomic) NSTimeInterval lastSpawnInterval;

@property (nonatomic) int runner1Position;
@property (nonatomic) int runner2Position;

@end

@implementation GameScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        self.runnerTexture = [SKTexture textureWithImageNamed:@"square"];
        self.spawnInterval = 0.7f;
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
    _lastSpawnInterval += timeSinceLast;
    if (_lastSpawnInterval > _spawnInterval) {
        
    }
}

-(void)didSimulatePhysics
{

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
            [_runner1 runAction:[SKAction moveToX:self.size.width / 4.0 duration:.1]];
        } break;
        case 1: {
            _runner1Position = 2;
            [_runner1 runAction:[SKAction moveToX:self.size.width * 3.0 / 8.0 duration:.1]];
        } break;
        case 2: {
            
        } break;
        default: break;
    }
    
    switch (_runner2Position) {
        case 0: {
            _runner2Position = 1;
            [_runner2 runAction:[SKAction moveToX:self.size.width * 3.0 / 4.0 duration:.1]];
        } break;
        case 1: {
            _runner2Position = 2;
            [_runner2 runAction:[SKAction moveToX:self.size.width * 7.0 / 8.0 duration:.1]];
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

@end
