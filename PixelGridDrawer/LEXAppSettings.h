//
//  LEXAppSettings.h
//  PixelGridDrawer
//
//  Created by iTech on 30.03.13.
//  Copyright (c) 2013 iTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LEXAppSettings : NSObject

+ (id)sharedSettings;

- (NSURL *)lastFileURL;
- (NSURL *)savePathURL;

- (void)setLastFileURL:(NSURL *)fileURL;

@end
