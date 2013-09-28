
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

// 记录程序开始时间，以后显示的时间均为与开始时间的间隔
static CFAbsoluteTime startTime = 0;

@interface XLogInternal : NSObject
+ (NSDictionary *)configDict;
+ (BOOL)shouldShowLogWithOwner:(NSString *)owner;
+ (BOOL)shouldShowAllLogs;
+ (BOOL)shouldShowItem:(NSString *)item;
@end


@implementation XLogInternal

+ (void)load
{
    startTime = CFAbsoluteTimeGetCurrent();
}

+ (NSDictionary *)configDict
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

+ (BOOL)shouldShowAllLogs
{
    NSDictionary* showDict = [self configDict][XLogPlistKeyShowOwner];
    return [showDict[XLogKeyAll] boolValue];
}

+ (BOOL)shouldShowLogWithOwner:(NSString *)owner
{
    NSDictionary* showDict = [self configDict][XLogPlistKeyShowOwner];
    return [showDict[owner] boolValue];
}

+ (BOOL)shouldShowItem:(NSString *)item
{
    NSDictionary* settingDict = [self configDict][XLogPlistKeySettings];
    return [settingDict[item] boolValue];
}

@end


void _XLogInternal(NSString* owner, const char* file, const char* func, unsigned int line, NSString* format, ...)
{
    // 根据plist选择要输出谁的log
    if (![XLogInternal shouldShowLogWithOwner:owner] && ![XLogInternal shouldShowAllLogs])
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
    
    if ([XLogInternal shouldShowItem:XLogKeyOwner])
    {
        [output appendFormat:@"(%@):",owner];
    }
    if ([XLogInternal shouldShowItem:XLogKeyTime])
    {
        CFAbsoluteTime time = CFAbsoluteTimeGetCurrent();
        [output appendFormat:@"[dt=%lf]", time - startTime];
    }
    if ([XLogInternal shouldShowItem:XLogKeyThread])
    {
        NSString* threadName = [NSThread isMainThread] ? @"main-thread" : [[NSThread currentThread] name];
        [output appendFormat:@"[%@]", threadName];
    }
    if ([XLogInternal shouldShowItem:XLogKeyFile])
    {
        NSString* fileName = [[[NSString stringWithFormat:@"%s", file] pathComponents] lastObject];
        [output appendFormat:@"[%@:%u]", fileName, line];
    }
    if ([XLogInternal shouldShowItem:XLogKeyFunction])
    {
        [output appendFormat:@"%s", func];
    }
    
    [output appendFormat:@" %@", message];
    
    fprintf(stderr, "%s", [output UTF8String]);
    
#if !__has_feature(objc_arc)
    [message release];
#endif

}

// convenients

NSString* XRect(CGRect rect)
{
    return NSStringFromCGRect(rect);
}
NSString* XPoint(CGPoint point)
{
    return NSStringFromCGPoint(point);
}
NSString* XSize(CGSize size)
{
    return NSStringFromCGSize(size);
}
NSString* XError(NSError* error)
{
    return [error localizedDescription];
}