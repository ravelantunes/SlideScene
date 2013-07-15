//
//  ViewController.m
//  SlideScene
//
//  Created by Ravel Antunes on 7/14/13.
//  Copyright (c) 2013 Ravel Antunes. All rights reserved.
//

#import "ViewController.h"

#import "Story.h"
#import "Slide.h"
#import "SlideScene.h"
#import "SlideDialog.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SlideScene *slideScene = [SlideScene sceneWithSize:skView.bounds.size];
    [slideScene setScaleMode:SKSceneScaleModeResizeFill];
    [skView presentScene:slideScene];
    
    Story *story = [self initializeStory];
    [slideScene showStory:story];
    
}


- (Story*)initializeStory{
    
    Slide *lakeScene = [[Slide alloc] init];
    [lakeScene setBackgroundImage:[UIImage imageNamed:@"beach.jpg"]];
    [lakeScene setTitle:@"Beach Scene"];
    
    SlideDialog *lakeDialog1 = [[SlideDialog alloc] init];
    [lakeDialog1 setText:@"Showing the first dialog!"];
    SlideDialog *lakeDialog2 = [[SlideDialog alloc] init];
    [lakeDialog2 setText:@"Now showing the second dialog."];
    
    [lakeScene setDialogs:@[lakeDialog1, lakeDialog2]];
    
    
    Slide *grassScene = [[Slide alloc] init];
    [grassScene setBackgroundImage:[UIImage imageNamed:@"forest.jpg"]];
    [grassScene setTitle:@"Forest Scene"];
    
    SlideDialog *grassDialog1 = [[SlideDialog alloc] init];
    [grassDialog1 setText:@"Now, the third and last dialog!"];
    
    [grassScene setDialogs:@[grassDialog1]];
    
    
    Story *story = [[Story alloc] init];
    [story setScenes:@[lakeScene, grassScene]];
    
    return story;
}


@end
