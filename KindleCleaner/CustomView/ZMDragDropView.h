//
//  ZMDragDropView.h
//  KindleCleaner
//
//  Created by Yuri Boyka on 2019/3/22.
//  Copyright © 2019 Godlike Studio. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol ZMDragDropViewDelegate <NSObject>
-(void)dragDropViewFileList:(NSArray*)fileList;
@end

@interface ZMDragDropView : NSView <NSDraggingDestination>
@property(assign) id<ZMDragDropViewDelegate> delegate;
@end


