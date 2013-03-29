//
//  LEXMainWindowController.m
//  PixelGridDrawer
//
//  Created by iTech on 30.03.13.
//  Copyright (c) 2013 iTech. All rights reserved.
//

#import "LEXMainWindowController.h"

#import "LEXGridDrawer.h"
#import "LEXTiledView.h"

#import "LEXAppSettings.h"

@interface LEXMainWindowController ()
@property (nonatomic, strong) LEXGridDrawer *gridDrawer;

- (void)colorChanged:(NSColorWell *)colorWell;
- (void)baseValueChanged:(NSStepper *)stepper;
- (void)highlightNeedsChange:(NSButton *)button;

- (IBAction)resetHighlightColor:(NSButton *)button;
- (IBAction)resetLineColor:(NSButton *)button;
- (IBAction)saveAsPNGAction:(id)sender;

- (void)updateImage;
- (void)configureDrawer;


@end

@implementation LEXMainWindowController


static inline NSColor * LEXLighterColor(NSColor *sourceColor, CGFloat offset)
{
    CGFloat redComponent;
    CGFloat greenComponent;
    CGFloat blueComponent;
    [sourceColor getRed:&redComponent
                  green:&greenComponent
                   blue:&blueComponent
                  alpha:NULL];
    redComponent += offset;
    greenComponent += offset;
    blueComponent += offset;
    
    NSColor *lighterColor = [NSColor colorWithDeviceRed:redComponent
                                                  green:greenComponent
                                                   blue:blueComponent
                                                  alpha:1.0f];
    return lighterColor;
}

- (void)dealloc
{
    _gridDrawer = nil;
}

- (void)awakeFromNib
{
    
    [_cellColorPicker setTarget:self];
    [_cellColorPicker setAction:@selector(colorChanged:)];
    
    [_lineColorPicker setTarget:self];
    [_lineColorPicker setAction:@selector(colorChanged:)];
    
    [_highlightColorPicker setTarget:self];
    [_highlightColorPicker setAction:@selector(colorChanged:)];
    
    [_baseStepper setTarget:self];
    [_baseStepper setAction:@selector(baseValueChanged:)];
    
    [_baseTextField setDelegate:self];
    
    [_highlightCheckButton setTarget:self];
    [_highlightCheckButton setAction:@selector(highlightNeedsChange:)];
    
    _gridDrawer = [[LEXGridDrawer alloc] init];
    [self updateImage];
}

- (void)configureDrawer
{
    _gridDrawer.cellColor = _cellColorPicker.color;
    _gridDrawer.lineColor = _lineColorPicker.color;
    _gridDrawer.highlightColor = _highlightColorPicker.color;
    _gridDrawer.width = _baseStepper.integerValue;
    _gridDrawer.shouldDrawHighlightLines = _highlightCheckButton.state;
}

- (void)updateImage
{
    [self configureDrawer];
    NSImage *image = _gridDrawer.constructedImage;
    _tiledView.image = image;
    _extraView.image = image;
}

- (void)highlightNeedsChange:(NSButton *)button
{
    [self updateImage];
}

- (void)colorChanged:(NSColorWell *)colorWell
{
    [self updateImage];
}

- (void)baseValueChanged:(NSStepper *)stepper
{
    [self updateImage];
}

- (void)controlTextDidEndEditing:(NSNotification *)obj
{
    [self updateImage];
}

- (void)resetLineColor:(NSButton *)button
{
    NSColor *color = LEXLighterColor(_cellColorPicker.color, -0.1f);
    _lineColorPicker.color = color;
    [self updateImage];
}

- (void)resetHighlightColor:(NSButton *)button
{
    NSColor *color = LEXLighterColor(_cellColorPicker.color, 0.1f);
    _highlightColorPicker.color = color;
    [self updateImage];
}

- (void)saveAsPNGAction:(id)sender
{
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    savePanel.allowedFileTypes = [NSArray arrayWithObjects:@"PNG", @"png", nil];
    savePanel.allowsOtherFileTypes = NO;
    savePanel.canCreateDirectories = YES;
    
    LEXAppSettings *appSettings = [LEXAppSettings sharedSettings];
    [savePanel setDirectoryURL:appSettings.savePathURL];
    NSInteger result = [savePanel runModal];
    if (result == NSFileHandlingPanelOKButton) {
        NSData *imagePNGRep = _tiledView.patternPNGRepresentation;
        BOOL success = [imagePNGRep writeToURL:savePanel.URL atomically:YES];
        if (!success) {
            NSAlert *alert = [NSAlert alertWithMessageText:@"Fail to save file"
                                             defaultButton:@"Ok"
                                           alternateButton:@""
                                               otherButton:@""
                                 informativeTextWithFormat:@"Fail to save file. Please, check directory's (and file's in case of overwriting) permissions or try to save file in another location"];
            [alert runModal];
        }
    }
}

@end
