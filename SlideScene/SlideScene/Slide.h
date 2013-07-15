//
//  Slide.h
//  SlideScene
//
//  Created by Ravel Antunes on 7/9/13.
//  Copyright (c) 2013 Ravel Antunes. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SlideDialog;

@interface Slide : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSArray *dialogs;
@property (strong, nonatomic) UIImage *backgroundImage;

@end
