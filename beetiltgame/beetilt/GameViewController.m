//
//  GameViewController.m
//  beetilt
//
//  Created by Ivan Borsa on 22/04/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameViewController.h"
#import "GameScene.h"
#import "GameOverScene.h"

@interface GameViewController ()

@property (nonatomic, weak) IBOutlet SKView *gameView;
@property (nonatomic, weak) IBOutlet SKView *topView;
@property (nonatomic, weak) IBOutlet SKView *bottomView;

@property (nonatomic) GameScene *gameScene;

@end

@implementation GameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_gameScene initEnvironment];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    // Configure the view.
    //SKView * skView = (SKView *)self.view;
    if (!_gameView.scene) {
        _gameView.showsFPS = YES;
        _gameView.showsNodeCount = YES;
        _gameView.showsPhysics = YES;
        
        // Create and configure the scene.
        _gameScene = [GameScene sceneWithSize:_gameView.bounds.size];
        _gameScene.scaleMode = SKSceneScaleModeAspectFill;
        _gameScene.delegate = self;
        
        // Present the scene.
        [_gameView presentScene:_gameScene];
    }
}

-(void)gameOverWithScore:(int)score
{
    //SKView * skView = (SKView *)self.view;
    GameOverScene *gos = [[GameOverScene alloc] initWithSize:_gameView.frame.size andScore:0];
    gos.delegate = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_gameView presentScene:gos transition:[SKTransition flipHorizontalWithDuration:.5]];
    });

    //[self.navigationController popViewControllerAnimated:YES];
}

-(void)quit
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)retry
{
    //SKView * skView = (SKView *)self.view;
    
    // Create and configure the scene.
    _gameScene = [GameScene sceneWithSize:_gameView.bounds.size];
    _gameScene.scaleMode = SKSceneScaleModeAspectFill;
    _gameScene.delegate = self;
    
    // Present the scene.
    [_gameView presentScene:_gameScene transition:[SKTransition flipHorizontalWithDuration:.5]];
    [_gameScene initEnvironment];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
