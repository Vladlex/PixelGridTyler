//
//  LEXMainWindowController.h
//  PixelGridDrawer
//
//  Created by iTech on 30.03.13.
//  Copyright (c) 2013 iTech. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class LEXTiledView;

@interface LEXMainWindowController : NSWindowController <NSTextFieldDelegate>

@property (nonatomic, strong) IBOutlet NSColorWell *cellColorPicker, *lineColorPicker, *highlightColorPicker;
@property (nonatomic, strong) IBOutlet NSTextField *baseTextField;
@property (nonatomic, strong) IBOutlet NSStepper *baseStepper;

@property (nonatomic, strong) IBOutlet NSButton *highlightCheckButton;

@property (nonatomic, strong) IBOutlet LEXTiledView *tiledView;
@property (nonatomic, strong) IBOutlet NSImageView *extraView;

@end
