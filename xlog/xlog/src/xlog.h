
// internal
void _XLog(NSString* owner,
                   NSUInteger level,
                   const char* file,
                   const char* func,
                   unsigned int line,
                   NSString* format, ...);

#define _XLogSettingPlist @"xlogconfig.plist"

// debuging switch
#ifdef DEBUG
#define XLogOLF(owner, level, format...) _XLog(owner, level, __FILE__,__PRETTY_FUNCTION__,__LINE__,format)
#else
#define XLog(owner, format...) do{}while(0)
#endif


// level define
typedef NS_OPTIONS(NSUInteger, XLogLevel)
{
    XLogInfoLevel     = 1 << 0, // 1(001)
    XLogWarningLevel  = 1 << 1, // 2(010)
    XLogErrorLevel    = 1 << 2, // 4(100)
};

// log
#define SYLog(format...)    XLog(@"sy", XLogInfoLevel, format)
#define CSLog(format...)    XLog(@"cs", XLogInfoLevel, format)
#define WYQLog(format...)   XLog(@"wyq",XLogInfoLevel, format)
#define ZZYLog(format...)   XLog(@"zzy",XLogInfoLevel, format)
#define ZHLog(format...)    XLog(@"zh", XLogInfoLevel, format)
#define TSCLog(format...)   XLog(@"tsc",XLogInfoLevel, format)
#define LWLog(format...)    XLog(@"lw", XLogInfoLevel, format)
#define PHMLog(format...)   XLog(@"phm",XLogInfoLevel, format)
#define WLLog(format...)    XLog(@"wl", XLogInfoLevel, format)
// warning
#define SYWarning(format...)    XLog(@"sy", XLogWarningLevel, format)
#define CSWarning(format...)    XLog(@"cs", XLogWarningLevel, format)
#define WYQWarning(format...)   XLog(@"wyq",XLogWarningLevel, format)
#define ZZYWarning(format...)   XLog(@"zzy",XLogWarningLevel, format)
#define ZHWarning(format...)    XLog(@"zh", XLogWarningLevel, format)
#define TSCWarning(format...)   XLog(@"tsc",XLogWarningLevel, format)
#define LWWarning(format...)    XLog(@"lw", XLogWarningLevel, format)
#define PHMWarning(format...)   XLog(@"phm",XLogWarningLevel, format)
#define WLWarning(format...)    XLog(@"wl", XLogWarningLevel, format)
// error
#define SYError(format...)    XLog(@"sy", XLogErrorLevel, format)
#define CSError(format...)    XLog(@"cs", XLogErrorLevel, format)
#define WYQError(format...)   XLog(@"wyq",XLogErrorLevel, format)
#define ZZYError(format...)   XLog(@"zzy",XLogErrorLevel, format)
#define ZHError(format...)    XLog(@"zh", XLogErrorLevel, format)
#define TSCError(format...)   XLog(@"tsc",XLogErrorLevel, format)
#define LWError(format...)    XLog(@"lw", XLogErrorLevel, format)
#define PHMError(format...)   XLog(@"phm",XLogErrorLevel, format)
#define WLError(format...)    XLog(@"wl", XLogErrorLevel, format)

// modules
#define DBLog(format...)        XLog(@"Database", XLogLevel, format)
#define DBWarning(format...)    XLog(@"Database", XLogWarningLevel, format)
#define DBError(format...)      XLog(@"Database", XLogErrorLevel, format)
#define NetworkLog(format...)        XLog(@"Network", XLogLevel, format)
#define NetworkWarning(format...)    XLog(@"Network", XLogWarningLevel, format)
#define NetworkError(format...)      XLog(@"Network", XLogErrorLevel, format)

// convenients
static inline NSString* XRect(CGRect rect) {return NSStringFromCGRect(rect);}
static inline NSString* XPoint(CGPoint point) {return NSStringFromCGPoint(point);}
static inline NSString* XSize(CGSize size) {return NSStringFromCGSize(size);}
static inline NSString* XError(NSError* error) {return [error localizedDescription];}


// -------------- new
struct XLogPredefines{
    const char* file;
    const char* func;
    const unsigned int line;
};



typedef NSString* (^XFormatHandler)(void* argumennt);

@interface XLogger : NSObject
+ (void)logWithOwner:(NSString *)owner
               level:(XLogLevel)level
              macros:(struct XLogPredefines)macros
              format:(NSString *)format, ...;

//+ (void)logWithOwner:(NSString *)owner
//               level:(XLogLevel)level
//                file:(const char *)file
//            function:(const char *)function
//                line:(unsigned int)line
//              format:(NSString *)format, ...;

//+ (void)addFormat:(NSString *)format handler:(XFormatHandler)handler;

@end

static inline void _XLog(NSString* owner, XLogLevel level, XLogPredefines macros, NSString* format, ...)
{
    [XLogger logWithOwner:owner level:level macros:macros format:format];
}

#define XLogGetPredefines() (XLogPredefines){__FILE__,__PRETTY_FUNCTION__,__LINE__}
#define XXLog(format, ...) _XLog(@"xx", XLogInfoLevel, XLogGetPredefines(), format)

