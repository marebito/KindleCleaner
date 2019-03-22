//
//  ZMAlert.m
//  KindleCleaner
//
//  Created by Yuri Boyka on 2019/3/22.
//  Copyright © 2019 Godlike Studio. All rights reserved.
//

#import "ZMAlert.h"

@implementation ZMAlert

+ (ZMAlert *)alertWithStyle:(kAlertStyle)style
                   titles:(NSArray *)titles
                  message:(NSString *)message
              informative:(NSString *)informative
               clickBlock:(void (^)(ZMAlert *alert, NSUInteger index))block
{
    ZMAlert *alert = [[ZMAlert alloc] init];
    for (NSString *title in titles)
    {
        [alert addButtonWithTitle:title];
    }
    [alert setAlertStyle:NSAlertStyleWarning];
    [alert setMessageText:message];
    [alert setInformativeText:informative];
    switch (style)
    {
        case kAlertStyleDefault:
        {
            NSUInteger action = [alert runModal];
            if (block) block(alert, action);
        }
        break;
        case kAlertStyleSheet:
        {
            [alert beginSheetModalForWindow:[[NSApplication sharedApplication].windows firstObject]
                          completionHandler:^(NSInteger result) {
                              if (block) block(alert, result);
                          }];
        }
        break;
        default:
            break;
    }
    return alert;
}

@end
