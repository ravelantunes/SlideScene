#SlideScene

SlideScene is a simple library built with SpriteKit objects to create a "slide show" with images and dialogs.
Useful to display some story, splash screens, or transitions.

##Model

#####SlideScene data model is based on 3 different objects:
1. Story - The parent object that will hold the entire story objects
2. Slide - The object that will take a background and will contain multiple dialogs
3. SlideDialog - The object that will contain text and will be added to a SlideScene

4.SlideScene - Extends SpriteKit's SKScene object


##Example
``` objective-c

    //Create a scene object
    Slide *mySlide = [[Slide alloc] init];
    [mySlide setBackgroundImage:[UIImage imageNamed:@"beach.jpg"]];
    [mySlide setTitle:@"Beach Slide"];
    
    //Create a dialog object
    SlideDialog *myDialog = [[SlideDialog alloc] init];
    [myDialog setText:@"I'm at the beach!"];
    
    //Add the dialog to the scene
    [mySlide setDialogs:@[myDialog]];
        
    //Create a story object and adds the scenes to it
    Story *story = [[Story alloc] init];
    [story setScenes:@[mySlide]];

    //Creates a slide scene object
    SlideScene *slideScene = [SlideScene sceneWithSize:currentView.bounds.size];
    [slideScene setScaleMode:SKSceneScaleModeResizeFill];
    [currentView presentScene:slideScene];
    
    //Makes the slideScen show the story
    [slideScene showStory:story];


```
