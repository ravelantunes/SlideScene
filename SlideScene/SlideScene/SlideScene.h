//
//  SlideScene.h
//  SlideScene
//
//  Created by Ravel Antunes on 7/9/13.
//  Copyright (c) 2013 Ravel Antunes. All rights reserved.
//


/*!
 To start the StoryTeller after instantiating, just
 pass a constructed Story object to the showStory:
 method. The Story will start showing immediatelly
 after the showStory: is called.
 The delegate must be implemented to be notified
 when the story finish all scene/dialogs.
 */
#import <SpriteKit/SpriteKit.h>

@protocol StoryTellerDelegate <NSObject>

@required
- (void)storyDidFinish;

@end

@class Story;

@interface SlideScene : SKScene

- (void)showStory:(Story*)story;

@property (weak, nonatomic) id<StoryTellerDelegate>delegate;

@end
