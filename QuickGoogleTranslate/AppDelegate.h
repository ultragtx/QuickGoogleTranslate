//
//  AppDelegate.h
//  QuickGoogleTranslate
//
//  Created by Xinrong Guo on 13-3-13.
//  Copyright (c) 2013年 Xinrong Guo. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "OBMenuBarWindow.h"
#import <WebKit/WebKit.h>

@interface AppDelegate : NSObject
<
NSApplicationDelegate,
OBMenuBarWindowDelegate
>

@property (assign) IBOutlet OBMenuBarWindow *window;

@end
