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

@property (nonatomic) BOOL newRow;

@end

@implementation GameScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        self.groundTexture = [SKTexture textureWithImageNamed:@"ground"];
    }
    return self;
}

-(void)initEnvironment
{
    [self removeAllChildren];
    
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
    
    self.newRow = YES;
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
    
}

-(void)addGround
{
    Ground *ground = [[Ground alloc] initWithTexture:_groundTexture];
    ground.position = CGPointMake(self.size.width / 2.0, self.size.height + ground.size.height * 3.0 / 2.0 - 3.0);
    SKAction *moveAction = [SKAction moveToY:-ground.size.height / 2.0 duration:4];
    [ground runAction:[SKAction sequence:@[moveAction, [SKAction removeFromParent]]]];
    [self addChild:ground];
}

-(void)gameObjectEnteredScene:(GameObject *)object
{
    if (!object.isOnScreen) {
        object.isOnScreen = YES;
        self.newRow = YES;
    }
}

-(void)gameObjectLeftScene:(GameObject *)object
{
    
}

-(void)didSimulatePhysics
{
    if (self.newRow) {
        self.newRow = NO;
        [self addGround];
    }
}

@end
