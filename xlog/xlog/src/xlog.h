
// internal
void _XLogInternal(NSString* owner,
                   const char* file,
                   const char* func,
                   unsigned int line,
                   NSString* format, ...);

#define _XLogSettingPlistName @"xlogconfig.plist"

#ifdef DEBUG
// convert from define to function
#define XLog(owner, format...) _XLogInternal(owner,__FILE__,__PRETTY_FUNCTION__,__LINE__,format)
#else
#define XLog(owner, format...) do{}while(0)
#endif

// usage
#define SYLog(format...)    XLog(@"sy", format)
#define CSLog(format...)    XLog(@"cs", format)
#define WYQLog(format...)   XLog(@"wyq", format)
#define ZZYLog(format...)   XLog(@"zzy", format)
#define ZHLog(format...)    XLog(@"zh", format)
#define TSCLog(format...)   XLog(@"tsc", format)
#define LWLog(format...)    XLog(@"lw", format)
#define PHMLog(format...)   XLog(@"phm", format)
#define WLLog(format...)    XLog(@"wl", format)

// convenients
NSString* XRect(CGRect rect);
NSString* XPoint(CGPoint point);
NSString* XSize(CGSize size);

NSString* XError(NSError* error);