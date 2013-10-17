
// internal
void _XLog (
    NSString* owner,
    NSUInteger level,
    const char* file,
    const char* func,
    unsigned int line,
    NSString* format, ...
);

#define _XLogSettingPlist @"xlogconfig.plist"

// debuging switch
#ifdef DEBUG
#define XLog(owner, level, format...) _XLog(owner, level, __FILE__,__PRETTY_FUNCTION__,__LINE__,format)
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

//+ (void)addFormat:(NSString *)format handler:(XFormatHandler)handler;

@end

