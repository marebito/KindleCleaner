//
//  ZMWireframe.m
//  KindleCleaner
//
//  Created by Yuri Boyka on 2019/3/22.
//  Copyright © 2019 Godlike Studio. All rights reserved.
//

#import "ZMWireframe.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation ZMWireframe

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    CGFloat dashPattern[]= {3.0, 2};
    CGContextRef ctx = nil;
    if (@available(macOS 11.4, *))
    {
        ctx = [[NSGraphicsContext currentContext] CGContext];
    }
    else
    {
        ctx = [[NSGraphicsContext currentContext] graphicsPort];
    }
    CGContextSetRGBStrokeColor(ctx, 1.0, 1.0, 1.0, 1.0);
    CGContextSetRGBFillColor(ctx, 0.0, 0.0, 0.0, 0.25);
    CGContextSetLineWidth(ctx, 3.0);
    CGContextSetLineDash(ctx, 0.0, dashPattern, 2);
    CGContextAddRect(ctx, self.bounds);
    CGContextClosePath(ctx);
    CGContextStrokePath(ctx);
    CGContextFillRect(ctx,CGRectMake(0,0,self.frame.size.width,self.frame.size.height));
}

@end
