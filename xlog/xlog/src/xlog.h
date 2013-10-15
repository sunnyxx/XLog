
// internal
void _XLogInternal(NSString* owner,
                   NSUInteger level,
                   const char* file,
                   const char* func,
                   unsigned int line,
                   NSString* format, ...);

#define _XLogSettingPlist @"xlogconfig.plist"

// debuging switch
#ifdef DEBUG
#define XLog(owner, level, format...) _XLogInternal(owner, level, __FILE__,__PRETTY_FUNCTION__,__LINE__,format)
#else
#define XLog(owner, format...) do{}while(0)
#endif

// level define
typedef NS_OPTIONS(NSUInteger, XLogLevelBits)
{
    XLogLevel   = 1 << 0, // 1(001)
    XWarnLevel  = 1 << 1, // 2(010)
    XErrorLevel = 1 << 2, // 4(100)
};

// log
#define SYLog(format...)    XLog(@"sy", XLogLevel, format)
#define CSLog(format...)    XLog(@"cs", XLogLevel, format)
#define WYQLog(format...)   XLog(@"wyq",XLogLevel, format)
#define ZZYLog(format...)   XLog(@"zzy",XLogLevel, format)
#define ZHLog(format...)    XLog(@"zh", XLogLevel, format)
#define TSCLog(format...)   XLog(@"tsc",XLogLevel, format)
#define LWLog(format...)    XLog(@"lw", XLogLevel, format)
#define PHMLog(format...)   XLog(@"phm",XLogLevel, format)
#define WLLog(format...)    XLog(@"wl", XLogLevel, format)
// warning
#define SYWarning(format...)    XLog(@"sy", XWarnLevel, format)
#define CSWarning(format...)    XLog(@"cs", XWarnLevel, format)
#define WYQWarning(format...)   XLog(@"wyq",XWarnLevel, format)
#define ZZYWarning(format...)   XLog(@"zzy",XWarnLevel, format)
#define ZHWarning(format...)    XLog(@"zh", XWarnLevel, format)
#define TSCWarning(format...)   XLog(@"tsc",XWarnLevel, format)
#define LWWarning(format...)    XLog(@"lw", XWarnLevel, format)
#define PHMWarning(format...)   XLog(@"phm",XWarnLevel, format)
#define WLWarning(format...)    XLog(@"wl", XWarnLevel, format)
// error
#define SYError(format...)    XLog(@"sy", XErrorLevel, format)
#define CSError(format...)    XLog(@"cs", XErrorLevel, format)
#define WYQError(format...)   XLog(@"wyq",XErrorLevel, format)
#define ZZYError(format...)   XLog(@"zzy",XErrorLevel, format)
#define ZHError(format...)    XLog(@"zh", XErrorLevel, format)
#define TSCError(format...)   XLog(@"tsc",XErrorLevel, format)
#define LWError(format...)    XLog(@"lw", XErrorLevel, format)
#define PHMError(format...)   XLog(@"phm",XErrorLevel, format)
#define WLError(format...)    XLog(@"wl", XErrorLevel, format)

// modules
#define DBLog(format...)        XLog(@"Database", XLogLevel, format)
#define DBWarning(format...)    XLog(@"Database", XWarnLevel, format)
#define DBError(format...)      XLog(@"Database", XErrorLevel, format)
#define NetworkLog(format...)        XLog(@"Network", XLogLevel, format)
#define NetworkWarning(format...)    XLog(@"Network", XWarnLevel, format)
#define NetworkError(format...)      XLog(@"Network", XErrorLevel, format)

// convenients
static inline NSString* XRect(CGRect rect) {return NSStringFromCGRect(rect);}
static inline NSString* XPoint(CGPoint point) {return NSStringFromCGPoint(point);}
static inline NSString* XSize(CGSize size) {return NSStringFromCGSize(size);}
static inline NSString* XError(NSError* error) {return [error localizedDescription];}

