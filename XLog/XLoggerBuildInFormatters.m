//
//  XLoggerBuildInFormatters.m
//  XLogDemo
//
//  Created by sunny on 13-10-19.
//  Copyright (c) 2013年 sunnyxx. All rights reserved.
//
//
//  XLoggerBuildInFormatters.m
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

#import "XLoggerBuildInFormatters.h"
#import "XLogger.h"

//----------
// CGPoint
//----------
@implementation XLoggerCGPointFormatter
+ (NSString *)format { return @"%P"; }
+ (NSString *)formattedStringFromArgumentList:(va_list *)ap
{
    return NSStringFromCGPoint(va_arg(*ap, CGPoint));
}
@end

//----------
// CGSize
//----------
@implementation XLoggerCGSizeFormatter
+ (NSString *)format { return @"%S"; }
+ (NSString *)formattedStringFromArgumentList:(va_list *)ap
{
    return NSStringFromCGSize(va_arg(*ap, CGSize));
}
@end

//----------
// CGRect
//----------
@implementation XLoggerCGRectFormatter
+ (NSString *)format { return @"%R"; }
+ (NSString *)formattedStringFromArgumentList:(va_list *)ap
{
    return NSStringFromCGRect(va_arg(*ap, CGRect));
}
@end

//----------
// Selector
//----------
@implementation XLoggerSelectorFormatter
+ (NSString *)format { return @"%SEL"; }
+ (NSString *)formattedStringFromArgumentList:(va_list *)ap
{
    return NSStringFromSelector(va_arg(*ap, SEL));
}
@end

//----------
// View
//----------
@implementation XLoggerViewRecursiveFormatter
+ (NSString *)format { return @"%V"; }
+ (NSString *)formattedStringFromArgumentList:(va_list *)ap
{
    UIView *view = va_arg(*ap, UIView *);
    SEL sel = NSSelectorFromString(@"recursiveDescription");
    NSString *description = @"";
    if ([view respondsToSelector:sel])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        description = [view performSelector:sel];
#pragma clang diagnostic pop
    }
    return description;
}
@end
