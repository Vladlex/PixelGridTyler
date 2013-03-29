//
//  LEXGridDrawer.m
//  PixelGridDrawer
//
//  Created by iTech on 30.03.13.
//  Copyright (c) 2013 iTech. All rights reserved.
//

#import "LEXGridDrawer.h"

@implementation LEXGridDrawer

static inline void LEXDrawCrosslines(CGContextRef context, CGSize size, CGSize offset, CGColorRef color)
{
    CGContextSetFillColorWithColor(context, color);
    int dash1X = 0 + offset.width;
    int dash1Y = size.height-1 + offset.height;
    
    int dash2X = 2 + offset.width;
    int dash2Y = 0 + offset.height;
    
    for (int i = 0; i < size.width; i ++) {
        CGRect lineRect1 = CGRectMake(dash1X, dash1Y, 2.0f, 1.0f);
        CGContextFillRect(context, lineRect1);
        dash1X += 2;
        dash1Y -= 1;
        
        CGRect lineRect2 = CGRectMake(dash2X, dash2Y, 2.0f, 1.0f);
        dash2X += 2;
        dash2Y += 1;
        CGContextFillRect(context, lineRect2);
    }
}

static inline CGContextRef LEXCreateContextWithSize(size_t width, size_t height)
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    size_t bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(NULL, width, height, bitsPerComponent, 0, colorSpace, kCGImageAlphaNoneSkipFirst);
    CGColorSpaceRelease(colorSpace);

    return context;
}

- (id)init
{
    self = [super init];
    if (self != nil) {
        _cellColor = [NSColor redColor];
        _lineColor = [NSColor blackColor];
        _highlightColor = [NSColor whiteColor];
        _shouldDrawHighlightLines = YES;
        _width = 36;
    }
    return self;
}

- (NSImage *)constructedImage
{
    size_t height = _width / 2;
    CGSize resultSize = CGSizeMake(_width, height);
    CGRect fillRect = {{0.0f, 0.0f}, resultSize};
    CGContextRef context = LEXCreateContextWithSize(_width, height);
    if (!context) {
        NSLog(@"Fail to create context");
        return  nil;
    }
    CGContextSetFillColorWithColor(context, _cellColor.CGColor);
    CGContextFillRect(context, fillRect);
    
    if (_shouldDrawHighlightLines) {
        LEXDrawCrosslines(context, resultSize, CGSizeMake(0, 1), _highlightColor.CGColor);
    }
    
    LEXDrawCrosslines(context, resultSize, CGSizeMake(0.0f, 0.0f), _lineColor.CGColor);
    
    CGImageRef image = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    NSImage *resultImage = [[NSImage alloc] initWithCGImage:image
                                                       size:resultSize];
    CGImageRelease(image);
    return resultImage;
}

@end
