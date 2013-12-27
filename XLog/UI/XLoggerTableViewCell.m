//
//  XLoggerTableViewCell.m
//  XLogDemo
//
//  Created by Sunny on 13-12-18.
//  Copyright (c) 2013年 sunnyxx. All rights reserved.
//

#import "XLoggerTableViewCell.h"
#import "XLogData.h"
#import "XLogMacros.h"
#import "XLoggerConfigurable.h"
@interface XLoggerTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *fileLabel;
@property (weak, nonatomic) IBOutlet UILabel *ownerLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *logLabel;
@property (weak, nonatomic) IBOutlet UIView *levelIndicatorView;

@end

@implementation XLoggerTableViewCell

- (void)setLogData:(XLogData *)logData
{
    self.fileLabel.text = [NSString stringWithFormat:@"%@:%d", [logData.file lastPathComponent], logData.line];
    self.ownerLabel.text = logData.owner;
    self.timeLabel.text = [NSString stringWithFormat:@"%.5lfs", logData.time];
    self.logLabel.text = logData.output;
    
    if (logData.level & XInfoLevel)
    {
        self.levelIndicatorView.backgroundColor = [UIColor whiteColor];
    }
    else if (logData.level & XWarningLevel)
    {
        self.levelIndicatorView.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5f];
    }
    else if (logData.level & XErrorLevel)
    {
        self.levelIndicatorView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5f];
        
    }
//    self.logLabel.text = @"XLOG:[AppDelegate.m:50] selector:application:didFinishLaunchingWithOptions:";
//    self.logLabel.backgroundColor = [UIColor blueColor];
}

@end
