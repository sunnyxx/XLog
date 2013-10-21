//
//  XLoggerConfigurable.h
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

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, XLogLevel)
{
    XInfoLevel     = 1 << 0, // 1(001)
    XWarningLevel  = 1 << 1, // 2(010)
    XErrorLevel    = 1 << 2, // 4(100)
};

typedef NSString* (^XFormatHandler)(void* argumennt);
@protocol XLoggerFormatter <NSObject>
@required
+ (NSString *)format;
+ (NSString *)formattedStringFromArgumentList:(va_list *)ap;
@end

@class XLogger;
@protocol XLoggerDelegate <NSObject>
@optional
+ (BOOL)XLogger:(XLogger *)logger shouldShowOwner:(NSString *)owner level:(XLogLevel)level;
+ (BOOL)XLogger:(XLogger *)logger shouldShowComponent:(NSString *)key;
+ (NSString *)XLogger:(XLogger *)logger titleForLevel:(XLogLevel)level;

@end

static NSString* const XLoggerComponentKeyOwner = @"XLoggerComponentKeyOwner";
static NSString* const XLoggerComponentKeyTime = @"XLoggerComponentKeyTime";
static NSString* const XLoggerComponentKeyFile = @"XLoggerComponentKeyFile";
static NSString* const XLoggerComponentKeyFunction = @"XLoggerComponentKeyFunction";
static NSString* const XLoggerComponentKeyThread = @"XLoggerComponentKeyThread";

static NSString* const XLoggerTitleKeyInfo = @"XLoggerTitleKeyInfo";
static NSString* const XLoggerTitleKeyWarning = @"XLoggerTitleKeyWarning";
static NSString* const XLoggerTitleKeyError = @"XLoggerTitleKeyError";

static NSString* const XLoggerOwnerKeyAll = @"XLoggerOwnerKeyAll";
