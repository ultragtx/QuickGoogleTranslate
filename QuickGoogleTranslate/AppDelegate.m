//
//  AppDelegate.m
//  QuickGoogleTranslate
//
//  Created by Xinrong Guo on 13-3-13.
//  Copyright (c) 2013年 Xinrong Guo. All rights reserved.
//

#import "AppDelegate.h"
#import <WebKit/WebKit.h>

@interface AppDelegate ()

@property (assign) IBOutlet WebView *webView;
@property (assign) IBOutlet NSButton *reloadButton;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.window.menuBarIcon = [NSImage imageNamed:@"MenuBarIcon"];
    self.window.highlightedMenuBarIcon = [NSImage imageNamed:@"MenuBarIcon2"];
    self.window.hasMenuBarIcon = YES;
    self.window.attachedToMenuBar = YES;
    
    [_webView setCustomUserAgent:@"Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_0 like Mac OS X; en-us) AppleWebKit/532.9 (KHTML, like Gecko) Version/4.0.5 Mobile/8A293 Safari/6531.22.7"];
    [_webView setMainFrameURL:@"http://translate.google.com"];
    
}

#pragma mark - 

- (IBAction)reload:(id)sender {
    [_webView setMainFrameURL:@"http://translate.google.com"];
}

@end
