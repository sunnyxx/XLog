
#import "XLog.h"

static NSString* const XLogPlistKeySettings = @"settings";
static NSString* const XLogPlistKeyShowOwner = @"show";

static NSString* const XLogKeyOwner = @"owner";
static NSString* const XLogKeyTime = @"timestamp";
static NSString* const XLogKeyFile = @"file";
static NSString* const XLogKeyFunction = @"function";
static NSString* const XLogKeyThread = @"thread";

static NSString* const XLogKeyLog = @"xlogTitle";
static NSString* const XLogKeyWarn = @"xwarningTitle";
static NSString* const XLogKeyError = @"xerrorTitle";

static NSString* const XLogKeyAll = @"ALL";

// 记录程序开始时间，以后显示的时间均为与开始时间的间隔
static CFAbsoluteTime startTime = 0;

@interface XLogInternal : NSObject
+ (NSDictionary *)configDict;
+ (BOOL)shouldShowLogOfOwner:(NSString *)owner level:(XLogLevel)bit;
+ (BOOL)shouldShowItem:(NSString *)item;
+ (NSString *)stringForItem:(NSString *)item;

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

+ (BOOL)shouldShowLogOfOwner:(NSString *)owner level:(XLogLevel)bit
{
    NSDictionary* showDict = [self configDict][XLogPlistKeyShowOwner];
    NSUInteger showBits = [showDict[owner] unsignedIntegerValue];
    NSUInteger allBits = [showDict[XLogKeyAll] unsignedIntegerValue];
    return (showBits & bit) || (allBits & bit);
}

+ (BOOL)shouldShowItem:(NSString *)item
{
    NSDictionary* settingDict = [self configDict][XLogPlistKeySettings];
    return [settingDict[item] boolValue];
}

+ (NSString *)stringForItem:(NSString *)item
{
    NSDictionary* settingDict = [self configDict][XLogPlistKeySettings];
    return settingDict[item];
}

+ (void)logWithOwner:(NSString *)owner level:(NSUInteger)bit file:(NSString *)file function:(NSString *)function line:(NSUInteger)line message:(NSString *)message
{
    // 根据plist选择要输出谁的log
    if (![XLogInternal shouldShowLogOfOwner:owner level:bit])
    {
        return;
    }
    
    // 根据plist设置输出的项
    NSString* levelString = nil;
    if (bit & XLogInfoLevel) levelString = [self stringForItem:XLogKeyLog];
    else if (bit & XLogWarningLevel) levelString = [self stringForItem:XLogKeyWarn];
    else if (bit & XLogErrorLevel) levelString = [self stringForItem:XLogKeyError];
    
    NSMutableString* output = [NSMutableString stringWithString:levelString];
    
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




// --------------------new
@interface XLogger ()
+ (void)logWithOwner:(NSString *)owner
               level:(NSUInteger)level
                file:(NSString *)file
            function:(NSString *)function
                line:(NSUInteger)line
              format:(NSString *)format, ...;

@end

@implementation XLogger

+ (void)logWithOwner:(NSString *)owner level:(NSUInteger)level file:(NSString *)file function:(NSString *)function line:(NSUInteger)line format:(NSString *)format, ...
{
    
}
@end


//-------------
// entrance
//-------------

void _XLog(NSString* owner, NSUInteger level, const char* file, const char* func, unsigned int line, NSString* format, ...)
{
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
    // forward
    [XLogger logWithOwner:owner
                    level:level
                     file:[NSString stringWithUTF8String:file]
                 function:[NSString stringWithUTF8String:func]
                     line:line
                   format:format];
}
