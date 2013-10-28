//
//  main.m
//  XLogDemo
//
//  Created by sunny on 13-10-18.
//  Copyright (c) 2013年 sunnyxx. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "XLog.h"

@interface MyXLogDelegate : NSObject <XLoggerDelegate>

@end

int main(int argc, char * argv[])
{
//    [[XLogger defaultLogger] setLevel:XAllLevel];
	XLog(@"normal info level");
	XWarning(@"warning level");
	XError(@"error level");
    [[XLogger defaultLogger] setLevel:XWarningLevel | XErrorLevel];
    [[XLogger defaultLogger] setDelegate:[MyXLogDelegate class]];
    XLog(@"normal info level");
	XWarning(@"warning level");
	XError(@"error level");
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
