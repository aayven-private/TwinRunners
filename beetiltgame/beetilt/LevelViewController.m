//
//  LevelView.m
//  twinrunners
//
//  Created by Ivan Borsa on 28/06/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import "LevelViewController.h"
#import "LevelScene.h"

@interface LevelViewController ()

@property (nonatomic, weak) IBOutlet SKView *levelView;

@property (nonatomic) LevelScene *levelScene;

@end

@implementation LevelViewController

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
    if (!_levelView.scene) {
        _levelView.showsFPS = YES;
        _levelView.showsNodeCount = YES;
        _levelView.showsPhysics = YES;
        
        // Create and configure the scene.
        _levelScene = [LevelScene sceneWithSize:_levelView.bounds.size];
        _levelScene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene.
        [_levelView presentScene:_levelScene];
    }
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
