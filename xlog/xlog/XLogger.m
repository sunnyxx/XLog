//
//  XLogger.m
//  XLog
//
//  Created by Sunny Sun on 18/10/13.
//  Copyright (c) 2013 Sunny Sun. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions
//  are met:
//  1. Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//  3. The name of the author may not be used to endorse or promote products
//  derived from this software without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
//  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
//  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
//  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
//  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
//  NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
//  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
//  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
//  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "XLogger.h"

static CFAbsoluteTime startTimeStamp = 0.0;

@implementation XLogger

+ (void)load
{
    startTimeStamp = CFAbsoluteTimeGetCurrent();
}

+ (instancetype)defaultLogger
{
    static dispatch_once_t onceToken;
    static XLogger* singleton = nil;
    dispatch_once(&onceToken, ^{
        singleton = [self new];
    });
    return singleton;
}

- (void)logWithOwner:(NSString *)owner level:(NSUInteger)level file:(NSString *)file function:(NSString *)function line:(NSUInteger)line format:(NSString *)format, ...
{
    // Ask delegate should show this log or not
    if (owner && [self.delegate respondsToSelector:@selector(XLogger:shouldShowOwner:level:)])
    {
        if (![self.delegate XLogger:self shouldShowOwner:owner level:level])
        {
            return;
        }
    }
    
    va_list ap;
    va_start(ap, format); {
        
        // Transfer delegate to block, with default setting
        BOOL (^shouldShowComponent)(NSString *) = ^(NSString* key){
            if ([self.delegate respondsToSelector:@selector(XLogger:shouldShowComponent:)])
            {
                return [self.delegate XLogger:self shouldShowComponent:key];
            }
            else
            {
                // Default add owner and filename(line number)
                return (BOOL)([key isEqualToString:XLoggerComponentKeyOwner] || [key isEqualToString:XLoggerComponentKeyFile]);
            }
            return NO;
        };
        
        // Combine components
        NSMutableString* output = [NSMutableString string];
        
        // add title
        NSString* title = @"XLOG"; // default
        if ([self.delegate respondsToSelector:@selector(XLogger:titleForLevel:)])
        {
            title = [self.delegate XLogger:self titleForLevel:level] ?: title;
        }
        [output appendString:title];
        
        // append owner or nil if should
        if (owner && shouldShowComponent(XLoggerComponentKeyOwner))
        {
            [output appendFormat:@"(%@):",owner];
        }
        else
        {
            [output appendFormat:@":"];
        }
        
        // append delta time from begining if needed
        if (shouldShowComponent(XLoggerComponentKeyTime))
        {
            CFAbsoluteTime now = CFAbsoluteTimeGetCurrent();
            [output appendFormat:@"[dt=%lf]", now - startTimeStamp];
        }
        
        // append thread message if needed
        if (shouldShowComponent(XLoggerComponentKeyThread))
        {
            NSString* threadName = [NSThread isMainThread] ? @"main-thread" : [[NSThread currentThread] name];
            [output appendFormat:@"[%@]", threadName];
        }
        
        // append
        if (file && shouldShowComponent(XLoggerComponentKeyFile))
        {
            NSString* fileName = [[[NSString stringWithFormat:@"%@", file] pathComponents] lastObject];
            [output appendFormat:@"[%@:%u]", fileName, line];
        }
        if (function && shouldShowComponent(XLoggerComponentKeyFunction))
        {
            [output appendFormat:@"%@", function];
        }
        
        // message
        NSString* message = [[NSString alloc] initWithFormat:format arguments:ap];
        [output appendFormat:@" %@", message];
        
        if (![output hasSuffix:@"\n"])
        {
            [output appendString:@"\n"];
        }
        
        // final print
        fprintf(stderr, "%s", [output UTF8String]);
        
    } va_end(ap);
    
        //    va_list ap, cp;
        //    va_start (ap, format);
        //    va_copy(cp, ap);
        //	NSString* message =  [[NSString alloc] initWithFormat:format arguments:cp];
        //
        //    NSRange searchRange = NSMakeRange(0, message.length);
        //    NSRange resultRange = NSMakeRange(NSNotFound, 0);
        //    do
        //    {
        //        NSRange resultRange = [format rangeOfString:@"$rect" options:NSCaseInsensitiveSearch range:searchRange];
        //        if (resultRange.length > 0)
        //        {
        //            searchRange.location = NSMaxRange(resultRange);
        //            searchRange.length = message.length - searchRange.location;
        //            NSLog(@"%@", NSStringFromRange(resultRange));
        //
        //        }
        //    }
        //    while (resultRange.location != NSNotFound);
        //
        //    NSArray* compoents = [format componentsSeparatedByString:@"$rect"];
        ////    [format stringByReplacingOccurrencesOfString:nil withString:nil];
        //
        //    va_end (ap);
        //
        //#if !__has_feature(objc_arc)
        //    [message autorelease];
        //#endif
        //

}
@end
