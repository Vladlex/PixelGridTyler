//
//  LEXGridDrawer.h
//  PixelGridDrawer
//
//  Created by iTech on 30.03.13.
//  Copyright (c) 2013 iTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LEXGridDrawer : NSObject
@property (nonatomic, assign) NSUInteger width;
@property (nonatomic, strong) NSColor *cellColor, *lineColor, *highlightColor;
@property (nonatomic, assign) BOOL shouldDrawHighlightLines;

- (NSImage *)constructedImage;

@end
