//
//  LEXTiledView.m
//  PixelGridDrawer
//
//  Created by iTech on 30.03.13.
//  Copyright (c) 2013 iTech. All rights reserved.
//

#import "LEXTiledView.h"

@interface LEXTiledView ()
- (void)beginDraggingWithEvent:(NSEvent *)event;

@end

@implementation LEXTiledView

static inline NSData *LEXImagePNGRepresentation(NSImage *image)
{
    [image lockFocus];
    CGSize imageSize = image.size;
    NSBitmapImageRep *imageRep = [[NSBitmapImageRep alloc] initWithFocusedViewRect:NSMakeRect(0.0f, 0.0f, imageSize.width, imageSize.height)];
    [image unlockFocus];
    return [imageRep representationUsingType:NSPNGFileType
                                  properties:nil];
}

- (void)setImage:(NSImage *)image
{
    if (_image != image) {
        _image = image;
        [self setNeedsDisplay:YES];
    }
}

- (NSData *)patternPNGRepresentation
{
    return LEXImagePNGRepresentation(_image);
}

- (void)drawRect:(NSRect)dirtyRect
{
    CGContextRef context = (CGContextRef)[NSGraphicsContext currentContext].graphicsPort;
    if (!_image) {
        CGContextFillEllipseInRect(context, dirtyRect);
    }
    else {
        NSColor *patternColor = [NSColor colorWithPatternImage:_image];
        CGContextSetFillColorWithColor(context, patternColor.CGColor);
        CGContextFillRect(context, dirtyRect);
    }
}

- (void)mouseDown:(NSEvent *)theEvent
{
    [self beginDraggingWithEvent:theEvent];
}

- (void)beginDraggingWithEvent:(NSEvent *)event
{
    NSSize dragOffset = NSMakeSize(0.0, 0.0); // not used in the method below, but required.
    NSPasteboard *pboard;
    pboard = [NSPasteboard pasteboardWithName:NSDragPboard];
    NSArray *types = [NSArray arrayWithObjects:NSPasteboardTypePNG,
    NSPasteboardTypeTIFF,
    nil];
    
    [pboard declareTypes:types owner:self];
    
    NSData *imageTIFFRepresentation = [_image TIFFRepresentationUsingCompression:NSTIFFCompressionNone
                                                                          factor:1.0f];
    [pboard setData:imageTIFFRepresentation
            forType:NSPasteboardTypeTIFF];
    NSData *imagePNGRepresentation = self.patternPNGRepresentation;
    [pboard setData:imagePNGRepresentation forType:NSPasteboardTypePNG];

    NSPoint touchLocation = [event locationInWindow];
    NSPoint dragLocation =[self convertPoint:touchLocation fromView:self.window.contentView];

    [self dragImage:_image
                 at:dragLocation
             offset:dragOffset
              event:event
         pasteboard:pboard
             source:self
          slideBack:YES];
    
    return;
}

#pragma mark -
#pragma mark NSDraggingSource Protocol

- (NSDragOperation)draggingSession:(NSDraggingSession *)session sourceOperationMaskForDraggingContext:(NSDraggingContext)context
{
    return NSDragOperationEvery;
}

- (BOOL)ignoreModifierKeysForDraggingSession:(NSDraggingSession *)session
{
    return YES;
}

- (BOOL)acceptsFirstMouse:(NSEvent *)theEvent
{
    return YES;
}

@end
