//
//  AppDelegate.m
//  QuickGoogleTranslate
//
//  Created by Xinrong Guo on 13-3-13.
//  Copyright (c) 2013年 Xinrong Guo. All rights reserved.
//

#import "AppDelegate.h"
#import <WebKit/WebKit.h>
#import "TestView.h"
#import "DDHotKeyCenter.h"

@interface AppDelegate ()

@property (assign) IBOutlet WebView *webView;
@property (assign) IBOutlet NSButton *reloadButton;

@property (strong, nonatomic) NSString *focusScript;
@property (strong, nonatomic) NSString *clickScript;
@property (strong, nonatomic) NSString *urlStr;


@property (assign) IBOutlet TestView *testView;


@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.window.menuBarIcon = [NSImage imageNamed:@"MenuBarIcon"];
    self.window.highlightedMenuBarIcon = [NSImage imageNamed:@"MenuBarIcon2"];
    self.window.hasMenuBarIcon = YES;
    self.window.attachedToMenuBar = YES;
    self.window.obDelegate = self;
    
    [self registerHotkey];
    [self loadWebView];
}

- (void)loadWebView {
    self.urlStr = @"http://translate.google.com/m/translate";
    self.focusScript = @"document.getElementsByClassName(\"orig\")[0].focus();";
    self.clickScript = @"document.getElementsByClassName(\"CSS_WUI_BUTTON CSS_WUI_ENABLED CSS_WUI_BUTTON_IMPL CSS_WUI_NO_TAP_HIGHLIGHT go CSS_WUI_IMG_BUTTON\")[0].click()";
    
    [_webView setFrameLoadDelegate:self];
    [_webView setCustomUserAgent:@"Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_0 like Mac OS X; en-us) AppleWebKit/532.9 (KHTML, like Gecko) Version/4.0.5 Mobile/8A293 Safari/6531.22.7"];
    [_webView setMainFrameURL:_urlStr];
}

- (void)applicationWillTerminate:(NSNotification *)notification {
    [self unregisterHotkey];
}

#pragma mark - Reload

- (IBAction)reload:(id)sender {
//    NSLog(@"reload");
    [_webView setMainFrameURL:_urlStr];
//    NSString *str = [_webView stringByEvaluatingJavaScriptFromString:_focusScript];

}

#pragma mark - obDelegate

- (void)obWindowDidAppear:(OBMenuBarWindow *)window {
    // simulate a mouse event to focus on the webview
    NSEvent *mouseEvent1 = [NSEvent mouseEventWithType:NSLeftMouseDown location:CGPointMake(1, 1) modifierFlags:0 timestamp:0 windowNumber:_window.windowNumber context:_window.graphicsContext eventNumber:0 clickCount:1 pressure:1];
    [NSApp postEvent:mouseEvent1 atStart:NO];
    
    NSEvent *mouseEvent2 = [NSEvent mouseEventWithType:NSLeftMouseUp location:CGPointMake(1, 1) modifierFlags:0 timestamp:0 windowNumber:_window.windowNumber context:_window.graphicsContext eventNumber:0 clickCount:1 pressure:1];
    [NSApp postEvent:mouseEvent2 atStart:NO];

    NSLog(@"%@", _webView.mainFrameURL);
    
    // give time to let the mouse event trigger and then focus tht input area
    [self performSelector:@selector(focusInput) withObject:nil afterDelay:0.1];
}

- (void)focusInput {
    if ([_webView.mainFrameURL isEqualToString:_urlStr]) {
        [_webView stringByEvaluatingJavaScriptFromString:_focusScript];
    }
}

#pragma mark - WebViewDelegate

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
//    NSLog(@"load");
    if (sender.mainFrame == frame) {
        [self focusInput];
    }
}

#pragma mark - Translate

- (IBAction)translate:(id)sender {
//    NSLog(@"translate");
    if ([_webView.mainFrameURL isEqualToString:_urlStr]) {
        [_webView stringByEvaluatingJavaScriptFromString:_clickScript];
    }
}

#pragma mark - Terminate

- (IBAction)terminate:(id)sender {
    [[NSApplication sharedApplication] terminate:self];
}

#pragma mark - Hotkey

- (IBAction) registerHotkey {
	DDHotKeyCenter * c = [[DDHotKeyCenter alloc] init];
	if (![c registerHotKeyWithKeyCode:2 modifierFlags:NSControlKeyMask | NSShiftKeyMask target:self action:@selector(hotkeyWithEvent:) object:nil]) {
	}
}

- (IBAction) unregisterHotkey {
	DDHotKeyCenter * c = [[DDHotKeyCenter alloc] init];
	[c unregisterHotKeyWithKeyCode:2 modifierFlags:NSControlKeyMask | NSShiftKeyMask];
}

- (void) hotkeyWithEvent:(NSEvent *)hkEvent {
//    NSLog(@"key");
    if ([_window isVisible]) {
        [NSApp hide:NSApp];
    }
    else {
        [NSApp activateIgnoringOtherApps:YES];
        [_window makeKeyAndOrderFront:_window];
    }
}

@end
