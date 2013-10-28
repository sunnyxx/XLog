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
#import "XLoggerBuildInFormatters.h"

@interface XLogger ()
- (NSString *)prefixStringWithOwner:(NSString *)owner level:(XLogLevel)level file:(NSString *)file func:(NSString *)func line:(NSUInteger)line;

// Formatter support
@property (nonatomic, strong) NSMutableArray* formatterClasses;
- (BOOL)containsCustomizedFormat:(NSString *)format;
- (NSString *)customizedFormat:(NSString *)format arguments:(va_list)ap;
@end

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
        singleton.level = XAllLevel;
        
        // Build-in formatters
        [singleton registerFormatterClass:[XLoggerCGPointFormatter class]];
        [singleton registerFormatterClass:[XLoggerCGSizeFormatter class]];
        [singleton registerFormatterClass:[XLoggerCGRectFormatter class]];
        [singleton registerFormatterClass:[XLoggerSelectorFormatter class]];
        
    });
    
    return singleton;
}

- (void)logWithOwner:(NSString *)owner level:(XLogLevel)level file:(NSString *)file function:(NSString *)function line:(NSUInteger)line format:(NSString *)format, ...
{
    // Ask delegate should show this log or not
    if (owner && [(NSObject *)self.delegate respondsToSelector:@selector(XLogger:shouldShowOwner:level:)])
    {
        if (![self.delegate XLogger:self shouldShowOwner:owner level:level])
        {
            return;
        }
    }
    // If delegate is not available, use property 'level'
    else if (!(self.level & level))
    {
        return;
    }
    
    NSMutableString* output = [NSMutableString string];
    {
        NSString* prefix = [self prefixStringWithOwner:owner level:level file:file func:function line:line];
        
        NSString* message = [NSString string]; {
            va_list ap;
            va_start(ap, format);
            message = [self customizedFormat:format arguments:ap];
            va_end(ap);
        }
        
        // assemble
        [output appendString:prefix];
        [output appendString:@" "];
        [output appendString:message];
    }
    
    // Handle line end
    if (![output hasSuffix:@"\n"])
    {
        [output appendString:@"\n"];
    }
    
    // Finally print
    fprintf(stderr, "%s", [output UTF8String]);

}

- (void)registerFormatterClass:(Class<XLoggerFormatter>)formatterClass
{
    if (!self.formatterClasses)
    {
        self.formatterClasses = [NSMutableArray array];
    }
    
    [self.formatterClasses addObject:formatterClass];
}

#pragma mark - Private

- (NSString *)prefixStringWithOwner:(NSString *)owner level:(XLogLevel)level file:(NSString *)file func:(NSString *)function line:(NSUInteger)line
{
    // Transfer delegate to block, with default setting
    BOOL (^shouldShowComponent)(NSString *) = ^(NSString* key){
        if ([(NSObject *)self.delegate respondsToSelector:@selector(XLogger:shouldShowComponent:)])
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
    NSMutableString* prefix = [NSMutableString string];
    
    // add title
    NSString* title = @"XLOG"; // default
    if ([(NSObject *)self.delegate respondsToSelector:@selector(XLogger:titleForLevel:)])
    {
        title = [self.delegate XLogger:self titleForLevel:level] ?: title;
    }
    [prefix appendString:title];
    
    // append owner or nil if should
    if (owner && shouldShowComponent(XLoggerComponentKeyOwner))
    {
        [prefix appendFormat:@"(%@):",owner];
    }
    else
    {
        [prefix appendFormat:@":"];
    }
    
    // append delta time from begining if needed
    if (shouldShowComponent(XLoggerComponentKeyTime))
    {
        CFAbsoluteTime now = CFAbsoluteTimeGetCurrent();
        [prefix appendFormat:@"[dt=%lf]", now - startTimeStamp];
    }
    
    // append thread message if needed
    if (shouldShowComponent(XLoggerComponentKeyThread))
    {
        NSString* threadName = [NSThread isMainThread] ? @"main-thread" : [[NSThread currentThread] name];
        [prefix appendFormat:@"[%@]", threadName];
    }
    
    // append
    if (file && shouldShowComponent(XLoggerComponentKeyFile))
    {
        NSString* fileName = [[[NSString stringWithFormat:@"%@", file] pathComponents] lastObject];
        [prefix appendFormat:@"[%@:%u]", fileName, line];
    }
    if (function && shouldShowComponent(XLoggerComponentKeyFunction))
    {
        [prefix appendFormat:@"%@", function];
    }
    
    return prefix;
}

- (BOOL)containsCustomizedFormat:(NSString *)format
{
    for (Class<XLoggerFormatter> formatterClass in self.formatterClasses)
    {
        NSString* specFormat = [formatterClass format];
        if ([format rangeOfString:specFormat].location != NSNotFound)
        {
            return YES;
        }
    }
    
    return NO;
}

- (void)moveArgumentListWithFormat:(NSString *)format arguments:(va_list *)ap
{
    // standard printf format parsing
    NSArray* components = [format componentsSeparatedByString:@"%"];
    for (int index = 1; index < components.count; index++)
    {
        NSString* component = components[index];
        NSRange range = [component rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]];
        NSString* sub = [component substringWithRange:range];
        
        char type = [sub characterAtIndex:0];
        switch (type)
        {
            case 'c':case 'C':
            case 'd':case 'i':case 'x':case 'o':case 'u':
                va_arg(*ap, int); // Promoted
                break;
            case 'l':case 'f':
                va_arg(*ap, double);  // Promoted
                break;
            case 's':
                va_arg(*ap, const char *);
            case '@':
                va_arg(*ap, id);
                break;
            case 'p':
                va_arg(*ap, void *);
            default:
                break;
        }
    }
}

- (NSString *)customizedFormat:(NSString *)format arguments:(va_list)ap
{
    NSMutableString* result = [NSMutableString string];
    
    // Exit recursive search if format doesn't contain a customized format.
    if (![self containsCustomizedFormat:format])
    {
        return [[NSString alloc] initWithFormat:format arguments:ap];
    }
    
    // Find the first format and its formatter class in formatters
    NSRange firstCustomizedFormatRange = NSMakeRange(NSNotFound, 0);
    Class<XLoggerFormatter> firstFormatterClass = Nil;
    
    for (Class<XLoggerFormatter> aClass in self.formatterClasses)
    {
        NSString* specFormat = [aClass format];
        NSRange specRange = [format rangeOfString:specFormat];
        if (specRange.location <= firstCustomizedFormatRange.location)
        {
            firstCustomizedFormatRange = specRange;
            firstFormatterClass = aClass;
        }
    }
    
    // Generate from the standard format and arguments IN FRONT
    NSRange subRangeFront = NSMakeRange(0, firstCustomizedFormatRange.location);
    NSString* subFormatFront = [format substringWithRange:subRangeFront];
    NSString* subStringFront = [[NSString alloc] initWithFormat:subFormatFront arguments:ap];
    [result appendString:subStringFront];
    
    // * Important * Move the argument list to current
    [self moveArgumentListWithFormat:subFormatFront arguments:&ap];

    
    // Generate with the specific formatter class IN SEARCHED OUT RANGE
    NSString* formattedString = [firstFormatterClass formattedStringFromArgumentList:&ap];
    [result appendString:formattedString];
    
    // Recursive end string
    NSRange subRangeEnd = NSMakeRange(NSMaxRange(firstCustomizedFormatRange), format.length - NSMaxRange(firstCustomizedFormatRange));
    NSString* subFormatEnd = [format substringWithRange:subRangeEnd];

    if (subRangeEnd.length > 0)
    {
        [result appendString:[self customizedFormat:subFormatEnd arguments:ap]];
    }
    
    return result;
}

@end
