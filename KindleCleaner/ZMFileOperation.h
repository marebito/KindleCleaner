//
//  ZMFileOperation.h
//  KindleCleaner
//
//  Created by Yuri Boyka on 2019/3/22.
//  Copyright © 2019 Godlike Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface ZMFileOperation : NSObject

+ (void)selectFilePath:(void (^)(NSInteger response, NSString *filePath))callback
                window:(NSWindow *)window
             isPresent:(BOOL)isPresent;

@end
