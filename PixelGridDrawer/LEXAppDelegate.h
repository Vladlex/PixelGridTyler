//
//  LEXAppDelegate.h
//  PixelGridDrawer
//
//  Created by iTech on 30.03.13.
//  Copyright (c) 2013 iTech. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class LEXMainWindowController;

@interface LEXAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, strong) IBOutlet LEXMainWindowController *mainWindowController;


@end
