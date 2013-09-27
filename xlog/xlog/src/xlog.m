
#import "xlog.h"

// 一级key
static NSString* const XLogPlistKeySettings = @"settings";
static NSString* const XLogPlistKeyShowOwner = @"show";

// 二级key
static NSString* const XLogKeyOwner = @"owner";
static NSString* const XLogKeyTime = @"time";
static NSString* const XLogKeyFile = @"file";
static NSString* const XLogKeyFunction = @"function";
static NSString* const XLogKeyThread = @"thread";

static NSString* const XLogKeyAll = @"ALL";

@interface <#class name#> : <#superclass#>

@end
NSDictionary* getConfigDict()
{
    static NSDictionary* dict = nil;
    if (!dict)
    {
        NSString* path = [[NSBundle mainBundle] pathForResource:_XLogSettingPlistName ofType:nil];
        dict = [NSDictionary dictionaryWithContentsOfFile:path];
        if (!dict)
        {
            NSLog(@"xlog.m - config file:%@ not found", _XLogSettingPlistName);
        }
    }
    return dict;
}

BOOL shouldShowLogWithOwner(NSString* owner)
{
    NSDictionary* showDict = getConfigDict()[XLogPlistKeyShowOwner];
    return [showDict[owner] boolValue];
}

BOOL shouldShowAllLogs()
{
    NSDictionary* showDict = getConfigDict()[XLogPlistKeyShowOwner];
    return [showDict[XLogKeyAll] boolValue];
}

BOOL shouldShowItem(NSString* item)
{
    NSDictionary* settingDict = getConfigDict()[XLogPlistKeySettings];
    return [settingDict[item] boolValue];
}


void _XLogInternal(NSString* owner, const char* file, const char* func, unsigned int line, NSString* format, ...)
{
    // 根据plist选择要输出谁的log
    if (!shouldShowLogWithOwner(owner) && !shouldShowAllLogs())
    {
        return;
    }
    
    // 根据va list生成message
    va_list ap;
	
    va_start (ap, format);
    if (![format hasSuffix: @"\n"])
    {
        format = [format stringByAppendingString: @"\n"];
	}
	NSString* message =  [[NSString alloc] initWithFormat:format arguments:ap];
	va_end (ap);
    
    // 根据plist设置输出的项
    NSMutableString* output = [NSMutableString stringWithFormat:@"XLOG"];
    
    if (shouldShowItem(XLogKeyOwner))
    {
        [output appendFormat:@"(%@):",owner];
    }
    if (shouldShowItem(XLogKeyTime))
    {
        CFAbsoluteTime time = CFAbsoluteTimeGetCurrent();
        
        [output appendFormat:@"[%lf]", time];
    }
    if (shouldShowItem(XLogKeyThread))
    {
        NSString* threadName = [NSThread isMainThread] ? @"main-thread" : [[NSThread currentThread] name];
        [output appendFormat:@"[%@]", threadName];
    }
    if (shouldShowItem(XLogKeyFile))
    {
        NSString* fileName = [[[NSString stringWithFormat:@"%s", file] pathComponents] lastObject];
        [output appendFormat:@"[%@:%u]", fileName, line];
    }
    if (shouldShowItem(XLogKeyFunction))
    {
        [output appendFormat:@"%s", func];
    }
    
    [output appendFormat:@" %@", message];
    
    fprintf(stderr, "%s\n", [output UTF8String]);
    
#if !__has_feature(objc_arc)
    [message release];
#endif

}

//
////* Base Format Logging *//
//static inline void _XLogF(char* file, unsigned int line, NSString* msg)
//{
//    NSString* fileName = [[[NSString stringWithFormat:@"%s", file] pathComponents] lastObject];
//    NSString* output = [NSString stringWithFormat:@"! XLog [%@:%d] %@",fileName,line,msg];
//    printf("%s\n", [output UTF8String]);
//}
//#define XLogF(FORMAT, ...) _XLogF(__FILE__,__LINE__,[NSString stringWithFormat:FORMAT, ##__VA_ARGS__])
//
////* Useful Extensions *//
//#define XLogObj(obj) XLogF(@"%@", (obj))
//#define XLogError(error) XLogF(@"NSError:[%d] %@",error.code, error.localizedDescription)
//
//#define XLogInt(value) XLogF(@"%d", (value))
//#define XLogFloat(value) XLogF(@"%f", (value))
//#define XLogRect(rect) XLogF(@"CGRect:%@", NSStringFromCGRect((rect)))
//#define XLogPoint(point) XLogF(@"CGPoint:%@", NSStringFromCGPoint((point)))
//
//

