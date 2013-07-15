//
//  SlideScene.m
//  SlideScene
//
//  Created by Ravel Antunes on 7/9/13.
//  Copyright (c) 2013 Ravel Antunes. All rights reserved.
//

#import "SlideScene.h"
#import "Story.h"
#import "Slide.h"
#import "SlideDialog.h"

const float kFadeAnimationTime = 0.5;

@interface SlideScene (){
    Story *_story;
    NSMutableArray *_currentSprites;
    
    Slide *_currentScene;
    SlideDialog *_currentDialog;
    
    SKSpriteNode *_currentSceneSprite;
    SKLabelNode *_currentDialogSprite;

    int _currentSceneIndex;
    int _currentDialogIndex;
}

@end

@implementation SlideScene

/*!
 This method is called by the owner of the
 SlideScene object to set a new Story 
 object. Once received, it will start displaying
 the scenes and dialogs.
 */
- (void)showStory:(Story*)story{
    _story = story;
    
    //Resets current scene to 0
    _currentSceneIndex = 0;
    
    //Check if there are scenes to show
    if (![_story.scenes count]) {
        NSLog(@"No scenes to show");
        return;
    }
    
    //Gets the scene object
    _currentScene = [_story.scenes objectAtIndex:0];
    
    //Make call to start story
    [self showScene];
    
}



#pragma mark - Scene/Dialog Handler

/*!
 This method will analyze the indexes of both
 current scene and current dialog, and determine if
 the next event should be to replace the scene or 
 the text
 */
- (void)playNextEvent{
    
    //Check if current scene has no more dialogs
    if (_currentDialogIndex >= [_currentScene.dialogs count]-1 ) {
        
        //Should play next scene
        _currentSceneIndex++;
        
        //Check if there are more scenes
        if (_currentSceneIndex < [_story.scenes count]) {
            
            //Show scene
            _currentScene = [_story.scenes objectAtIndex:_currentSceneIndex];
            [self showScene];

        } else {
            
            //Call back that story did finish
            [self.delegate storyDidFinish];
            return;
        }
        
    } else {
        
        //Should play next dialog
        _currentDialogIndex++;
        _currentDialog = [_currentScene.dialogs objectAtIndex:_currentDialogIndex];
        [self showDialog];
        
    }
    
}


/*!
 This method will show the scene that the
 _currentScene iVar is pointing to. Then if
 it contains any dialog, it will also set
 the first dialog as the _currentDialog, and
 call showDialog method.
*/
- (void)showScene{

    //Gets the texture for the sprite
    SKTexture *texture = [SKTexture textureWithImage:[_currentScene backgroundImage]];
    CGSize size = CGSizeMake(480, 320);
    
    //Creates sprite
    _currentSceneSprite = [SKSpriteNode spriteNodeWithTexture:texture size:size];
    [_currentSceneSprite setAnchorPoint:CGPointMake(0, 0)];
    [_currentSceneSprite setPosition:CGPointMake(0, 0)];
    

    //Fade in
    [_currentSceneSprite setAlpha:0];
    [self addChild:_currentSceneSprite];
    [_currentSceneSprite runAction:[SKAction fadeInWithDuration:kFadeAnimationTime]];
    
    //Check if scene has a dialog
    if ([_currentScene.dialogs count]) {
        _currentDialog = [_currentScene.dialogs objectAtIndex:0];
        _currentDialogIndex = 0;        
        [self performSelector:@selector(showDialog) withObject:Nil afterDelay:0.1];
    }

}


/*!
 This method will show the dialog that the
 _currentDialog iVar is pointing to. If
 there is a current dialog showing on screen,
 it will call an animation to fade it out.
 */
- (void)showDialog{
    
    if (_currentDialogSprite) {
        
        //Removes the old label
        [_currentDialogSprite runAction:[SKAction fadeOutWithDuration:kFadeAnimationTime] completion:^{
            
            [self showDialogCallbackFunction];
            
        }];    
        
    } else {
        [self showDialogCallbackFunction];
    }
    
}


/*!
 This method is where the actual work is done
 to show a dialog. This is implemented in a
 different method so it can be used as a callback.
 However, it is only should only be called from
 showDialog method.
 */
- (void)showDialogCallbackFunction{
    
    //Animation callback
    [_currentDialogSprite removeFromParent];
    
    //Creates label node sprite
    _currentDialogSprite = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    [_currentDialogSprite setText:_currentDialog.text];
    
    //Creates the position
    CGPoint labelPosition;
    labelPosition = CGPointMake(self.size.width/2, self.size.height*0.1);

    [_currentDialogSprite setPosition:labelPosition];
    [_currentDialogSprite setFontSize:15];
    
    //Adds to scene
    [_currentDialogSprite setAlpha:0];
    [_currentSceneSprite addChild:_currentDialogSprite];
    [_currentDialogSprite runAction:[SKAction fadeInWithDuration:kFadeAnimationTime]];
    
}


#pragma mark - Touch Events

/*!
 Listen for touch events and call next event method
 to be played
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        //Detecs for a touch anywhere.
        [self playNextEvent];
    }
}


@end
