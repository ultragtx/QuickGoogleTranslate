//
//  TestView.m
//  QuickGoogleTranslate
//
//  Created by Xinrong Guo on 13-3-13.
//  Copyright (c) 2013年 Xinrong Guo. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

- (void)mouseDown:(NSEvent *)theEvent {
    NSLog(@"%@", [theEvent description]);
}

@end
