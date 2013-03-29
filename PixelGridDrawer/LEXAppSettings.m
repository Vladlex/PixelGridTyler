//
//  LEXAppSettings.m
//  PixelGridDrawer
//
//  Created by iTech on 30.03.13.
//  Copyright (c) 2013 iTech. All rights reserved.
//

#import "LEXAppSettings.h"

NSString * const LEXUserDefaultsLastFileURLKey = @"LEXLastFileURL";

@implementation LEXAppSettings

+ (id)sharedSettings {
    __strong static id sharedObject = nil;
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, ^{
        sharedObject = [[ self alloc ] init ];
    });
    return sharedObject;
}

- (NSURL *)lastFileURL
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:LEXUserDefaultsLastFileURLKey];
}

- (NSURL *)savePathURL
{
    NSURL *saveURL = [self lastFileURL];
    if (!saveURL) {
        saveURL = [NSURL fileURLWithPath:NSHomeDirectory()
                             isDirectory:YES];
    }
    return saveURL;
}

- (void)setLastFileURL:(NSURL *)fileURL
{
    [[NSUserDefaults standardUserDefaults] setObject:fileURL
                                              forKey:LEXUserDefaultsLastFileURLKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
