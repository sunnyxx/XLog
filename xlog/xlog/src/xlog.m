
#import "xlog.h"

static NSString* const XLogPlistKeySettings = @"settings";
static NSString* const XLogPlistKeyShowOwner = @"show";

static NSString* const XLogKeyOwner = @"owner";
static NSString* const XLogKeyTime = @"timestamp";
static NSString* const XLogKeyFile = @"file";
static NSString* const XLogKeyFunction = @"function";
static NSString* const XLogKeyThread = @"thread";

static NSString* const XLogKeyAll = @"ALL";

// 记录程序开始时间，以后显示的时间均为与开始时间的间隔
static CFAbsoluteTime startTime = 0;

@interface XLogInternal : NSObject
+ (NSDictionary *)configDict;
+ (BOOL)shouldShowLogOfOwner:(NSString *)owner;
+ (BOOL)shouldShowAllLogs;
+ (BOOL)shouldShowItem:(NSString *)item;

+ (void)logWithOwner:(NSString *)owner file:(NSString *)file function:(NSString *)function line:(NSUInteger)line message:(NSString *)message;
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
        NSString* path = [[NSBundle mainBundle] pathForResource:_XLogSettingPlist ofType:nil];
        dict = [NSDictionary dictionaryWithContentsOfFile:path];
        if (!dict)
        {
            NSLog(@"xlog.m - config file:%@ not found", _XLogSettingPlist);
        }
    }
    return dict;
}

+ (BOOL)shouldShowAllLogs
{
    NSDictionary* showDict = [self configDict][XLogPlistKeyShowOwner];
    return [showDict[XLogKeyAll] boolValue];
}

+ (BOOL)shouldShowLogOfOwner:(NSString *)owner
{
    NSDictionary* showDict = [self configDict][XLogPlistKeyShowOwner];
    return [showDict[owner] boolValue];
}

+ (BOOL)shouldShowItem:(NSString *)item
{
    NSDictionary* settingDict = [self configDict][XLogPlistKeySettings];
    return [settingDict[item] boolValue];
}

+ (void)logWithOwner:(NSString *)owner file:(NSString *)file function:(NSString *)function line:(NSUInteger)line message:(NSString *)message
{
    // 根据plist选择要输出谁的log
    if (![XLogInternal shouldShowLogOfOwner:owner] && ![XLogInternal shouldShowAllLogs])
    {
        return;
    }
    
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
        NSString* fileName = [[[NSString stringWithFormat:@"%@", file] pathComponents] lastObject];
        [output appendFormat:@"[%@:%u]", fileName, line];
    }
    if ([XLogInternal shouldShowItem:XLogKeyFunction])
    {
        [output appendFormat:@"%@", function];
    }
    
    [output appendFormat:@" %@\n", message];
    
    fprintf(stderr, "%s", [output UTF8String]);
}

@end

void _XLogInternal(NSString* owner, const char* file, const char* func, unsigned int line, NSString* format, ...)
{
    va_list ap;
    va_start (ap, format);
	NSString* message =  [[NSString alloc] initWithFormat:format arguments:ap];
    va_end (ap);

#if !__has_feature(objc_arc)
    [message autorelease];
#endif
    
    // do log
    [XLogInternal logWithOwner:owner
                          file:[NSString stringWithUTF8String:file]
                      function:[NSString stringWithUTF8String:func]
                          line:line
                       message:message];
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
