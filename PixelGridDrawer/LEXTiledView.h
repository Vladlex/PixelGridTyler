//
//  LEXTiledView.h
//  PixelGridDrawer
//
//  Created by iTech on 30.03.13.
//  Copyright (c) 2013 iTech. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LEXTiledView : NSView
@property (nonatomic, strong) NSImage *image;

- (NSData *)patternPNGRepresentation;

@end
