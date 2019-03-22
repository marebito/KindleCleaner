//
//  ViewController.m
//  KindleCleaner
//
//  Created by Yuri Boyka on 2019/3/22.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import "ViewController.h"
#import "ZMDragDropView.h"
#import "ZMAlert.h"
#import "ZMIndicator.h"

@interface ViewController ()<ZMDragDropViewDelegate>
@property(weak) IBOutlet ZMDragDropView *dragDropView;
@property(weak) IBOutlet NSImageView *statusImageView;
@property(weak) IBOutlet NSView *kindleImageView;
@property(weak) IBOutlet NSButton *resetBtn;
- (IBAction)reset:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dragDropView.delegate = self;
}
- (void)setRepresentedObject:(id)representedObject { [super setRepresentedObject:representedObject]; }
- (void)dragDropViewFileList:(NSArray *)fileList
{
    if (!fileList || [fileList count] <= 0) return;
    NSString *documentsDir = [fileList firstObject];
    BOOL isDir;
    [[NSFileManager defaultManager] fileExistsAtPath:documentsDir isDirectory:&isDir];
    if (!isDir)
    {
        [ZMAlert alertWithStyle:kAlertStyleSheet
                         titles:@[ @"确定" ]
                        message:@"友情提示"
                    informative:@"请拖入Kindle设备中的documents文件夹"
                     clickBlock:^(ZMAlert *alert, NSUInteger index){
                     }];
        return;
    }
    self.statusImageView.hidden = YES;
    self.kindleImageView.hidden = NO;
    self.resetBtn.hidden = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int n = 0; n < [fileList count]; n++)
        {
            NSLog(@">>> %@", [fileList objectAtIndex:n]);
            [self cleanSDR:fileList[0]];
        }
    });
}

- (id)cleanSDR:(NSString *)dir
{
    NSTask *shellTask = [[NSTask alloc] init];
    [shellTask setLaunchPath:@"/bin/sh"];
    [shellTask setArguments:@[ [[NSBundle mainBundle] pathForResource:@"KindleCleaner" ofType:@"sh"], dir ]];
    NSPipe *pipe = [[NSPipe alloc] init];
    [shellTask setStandardOutput:pipe];
    [shellTask launch];
    NSFileHandle *file = [pipe fileHandleForReading];
    NSData *data = [file readDataToEndOfFile];
    NSString *strReturnFromShell = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    __weak typeof(self) weakSelf = self;
    if ([strReturnFromShell isEqualToString:@"0\n"])
    {
        __strong typeof(self) strongSelf = weakSelf;
        [ZMAlert alertWithStyle:kAlertStyleSheet
                         titles:@[ @"确定" ]
                        message:@"友情提示"
                    informative:@"Kindle残留文件清除完毕！请断开USB连接..."
                     clickBlock:^(ZMAlert *alert, NSUInteger index) {
                         [strongSelf reset:nil];
                     }];
    }
    return strReturnFromShell;
}

- (IBAction)reset:(id)sender
{
    self.statusImageView.hidden = NO;
    self.kindleImageView.hidden = YES;
    self.resetBtn.hidden = YES;
}
@end
