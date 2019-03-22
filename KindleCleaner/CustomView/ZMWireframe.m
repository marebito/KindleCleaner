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
    
    /*
     let radius = self.headImageView.frame.width/2 + 3 //半径
     let arcCenter = self.headImageView.center//圆心
     //通过贝塞尔曲线画出圆弧，参数分别为圆心、半径、开始弧度、结束弧度、顺/逆时针
     self.arcLayer.path = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: conversionRadian(90), endAngle: conversionRadian(360*complete+90), clockwise: true).CGPath
     self.arcLayer.fillColor = UIColor.clearColor().CGColor//填充色
     self.arcLayer.strokeColor = UIColor.redColor().CGColor//画笔色
     self.arcLayer.lineWidth = 6//线宽度
     self.arcLayer.lineDashPattern = [2,1]//设置虚线样式，数组
     let drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
     drawAnimation.duration            = 0.5;
     drawAnimation.repeatCount         = 1.0;
     drawAnimation.removedOnCompletion = false;
     drawAnimation.fromValue = 0
     drawAnimation.toValue = 1
     drawAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
     self.arcLayer.addAnimation(drawAnimation, forKey: "strokeEnd")
     //创建渐变图层
     self.gradientLayer.frame = CGRect(x: 0, y: 0, width: self.headImageBgView.frame.width, height: self.headImageBgView.frame.height)
     self.gradientLayer.colors = [UIColor(hexString: "#FFDD74", alpha: 1)!.CGColor,UIColor(hexString: "#FF6000", alpha: 1)!.CGColor]
     self.gradientLayer.startPoint = CGPoint(x: 0, y: 0)//开始左上角
     self.gradientLayer.endPoint = CGPoint(x: 1, y: 1)//结束点右下角
     self.gradientLayer.mask = self.arcLayer
     self.headImageBgView.layer.addSublayer(self.gradientLayer)
     */
}

@end
